import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';


class GroceryItems extends StatelessWidget{
  GroceryItems ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Your Grocery'),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: ((context, index) => ListTile(
            title:Text(groceryItems[index].name),
            leading: Container(
              width:20,
              height: 20,
              color: groceryItems[index].category.color,
            ),
            trailing: Text(groceryItems[index].quantity.toString()),

        )))
      ) ,
    );
  }
}