import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:shopping_list_app/model/grocery_items.dart';

class GroceryItems extends StatefulWidget {
  GroceryItems({super.key});


  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
    final List<GroceryItem> _grocaryItem=[];

  void _addItem() async{
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    );
    if(newItem==null){
      return;
    }
    setState(() {
    _grocaryItem.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content=Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Oh No There Is no Items',style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground
          ),),
          const SizedBox(height: 16,),
          Text('Please enter some data',style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground
          ),)
        ],
      ),
    );
    if(_grocaryItem.isNotEmpty){
       content=Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: _grocaryItem.length,
              itemBuilder: ((context, index) => ListTile(
                    title: Text(_grocaryItem[index].name),
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: _grocaryItem[index].category.color,
                    ),
                    trailing: Text(_grocaryItem[index].quantity.toString()),
                  ))));
    }
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
        title: const Text('Your Grocery'),
      ),
      body:content
       
    );
  }
}
