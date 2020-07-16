import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class ShoppingList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final List<String> fruits = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
              color: Colors.pink
          ),
          title: Text("User\'s Shopping List"),
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: _buildShoppingListItem,
              itemCount: fruits.length, // you can eliminate this param to make it infinite
            )
        )
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( fruits[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }
}
