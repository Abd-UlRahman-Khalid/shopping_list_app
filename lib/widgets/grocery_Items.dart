import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryItems extends StatefulWidget {
  GroceryItems({super.key});

  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
        title: const Text('Your Grocery'),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: groceryItems.length,
              itemBuilder: ((context, index) => ListTile(
                    title: Text(groceryItems[index].name),
                    leading: Container(
                      width: 20,
                      height: 20,
                      color: groceryItems[index].category.color,
                    ),
                    trailing: Text(groceryItems[index].quantity.toString()),
                  )))),
    );
  }
}
