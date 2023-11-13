import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Text('New Item'),
    );
  }
}