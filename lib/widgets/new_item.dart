import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/categories.dart';
import 'package:shopping_list_app/model/grocery_items.dart';

class NewItem extends StatefulWidget {
  NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _StateNewItem();
  }
}

class _StateNewItem extends State<NewItem> {
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _seletedCategory = categories[Categories.vegetables]!;
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('flutter-prep-c0f70-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _seletedCategory.title,
          },
        ),
      );

      final Map<String, dynamic> restData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(GroceryItem(
          id: restData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _seletedCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <=
                            1 || //trim remove any space at begning & end
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                        initialValue: '1',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) ==
                                  null || //tryParse give null if the input is String
                              int.tryParse(value)! <= 0) {
                            //avoid enter negative value
                            return 'Must be a valid, positive number.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Quantity'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _seletedCategory,
                          items: [
                            for (final category in categories
                                .entries) //entries change the map of categories into List
                              DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      // Square shape beside the Category
                                      width: 10,
                                      height: 10,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(category.value.title)
                                  ],
                                ),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _seletedCategory = value!;
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Reset')),
                    ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Add Item'),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}