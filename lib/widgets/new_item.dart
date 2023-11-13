import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/categories.dart';

class NewItem extends StatefulWidget{
  NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _StateNewItem();
  }
}

class _StateNewItem extends State<NewItem>{
  final _formKey=GlobalKey<FormState>();
  void _saveItem(){
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [],
      title: Text('Add New Item'),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (value){
                if(value == null || value.isEmpty || value.trim().length <=1 || value.trim().length> 50){
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
                    initialValue: '1',
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value == null|| value.isEmpty ||int.tryParse(value)==null ||int.tryParse(value)!<= 0){
                        return 'Must be a valid, positive number.';
                      }
                  return null;
                },
                    decoration: const InputDecoration(
                      label: Text('Quantity'),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: DropdownButtonFormField(items: [
                    for (final category in categories.entries)//entries change the map into List
                    DropdownMenuItem(
                      value: category.value,
                      child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: category.value.color,
                        ),
                        const SizedBox(width: 6,),
                        Text(category.value.title)
                      ],
                    ),)
                  ], onChanged: (value){}),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed:(){
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Reset')),
                ElevatedButton(
                  onPressed:  _saveItem,
                  child: const Text('Add Item'))
              ],
            )
          ],
        )),),
    );
  }
}