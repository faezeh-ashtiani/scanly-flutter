import 'package:flutter/material.dart';


class ShoppingList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final mnBlue = Color(0xff34558B);
  final chineseYellow = Color(0xffffb41f);

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
