import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget{
  HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Your Grocery'),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 16,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Milk'),
                  Spacer(),
                  Text('1'),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Banana'),
                  Spacer( ),
                  Text('5'),
                ],
            ),
              ),
            SizedBox(height: 16,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 238, 58, 8),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Beef Steak'),
                  Spacer(),
                  Text('1'),
                ],
              ),
            )
          ],
        ),
      ) ,
    );
  }
}