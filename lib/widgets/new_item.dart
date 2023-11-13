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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [],
      title: Text('Add New Item'),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (vale){return 'Demo...';},
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: '1',
                    decoration: const InputDecoration(
                      label: Text('Quantity'),
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField(items: [
                    for (final category in categories.entries)//entries change the map into List
                    DropdownMenuItem(
                      value: category.value,
                      child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          color: category.value.color,
                        ),
                        SizedBox(width: 6,),
                        Text(category.value.title)
                      ],
                    ))
                  ], onChanged: (value){}),
                )
              ],
            )
          ],
        )),),
    );
  }
}