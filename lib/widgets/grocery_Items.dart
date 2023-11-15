import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:shopping_list_app/model/grocery_items.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryItems extends StatefulWidget {
  GroceryItems({super.key});

  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
  List<GroceryItem> _grocaryItem = [];

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
        'flutter-prep-c0f70-default-rtdb.firebaseio.com', 'shopping-list.json');
    final responed = await http.get(url);
    final List<GroceryItem> loadedItems = [];

    final Map<String, dynamic> listData =
        json.decode(responed.body);
    for (final item in listData.entries) {
      final category=categories.entries.firstWhere((catItem) => catItem.value.title == item.value['category']).value;
      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }
    setState(() { 
    _grocaryItem=loadedItems;
    });
  }

  void _addItem() async {
    final newItem= await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    );
    if(newItem == null){
      return;
    }

    setState(() {
      _grocaryItem..add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _grocaryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Oh No There Is no Items',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Please enter some data',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );
    if (_grocaryItem.isNotEmpty) {
      content = Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: _grocaryItem.length,
              itemBuilder: ((context, index) => Dismissible(
                    onDismissed: (direction) {
                      _removeItem(_grocaryItem[index]);
                    },
                    key: ValueKey(_grocaryItem[index].id),
                    child: ListTile(
                      title: Text(_grocaryItem[index].name),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: _grocaryItem[index].category.color,
                      ),
                      trailing: Text(_grocaryItem[index].quantity.toString()),
                    ),
                  ))));
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
          title: const Text('Your Grocery'),
        ),
        body: content);
  }
}
