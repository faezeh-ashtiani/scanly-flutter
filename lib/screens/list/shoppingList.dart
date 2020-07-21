import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class ShoppingList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final mnBlue = Color(0xff34558B);
  final chineseYellow = Color(0xffffb41f);

  List<String> _shoppingList = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

  _getShoppingList() async {
    // make GET request
    String url = "http://192.168.86.21:8080/getShoppingList?name=hala";
    Response response = await get(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
//    print(json);
    Map<String, dynamic> map = jsonDecode(json);
//    print(map);
    print(map["result"][0]["name"]as String);
//    Iterable<String> testList = map["result"].map((listItem) {
//      return listItem["name"] as String;
//    } as String);

    List<String> localList = [];
    for (var listItem in map["result"]) {
      localList.add(listItem["name"]);
    }
//    map["result"].map((listItem) => listItem["name"] as String).toList();
    print(localList);
    setState(() {
      _shoppingList = localList;
    });
  }
//
//  final List<String> fruits = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: chineseYellow,
          iconTheme: IconThemeData(
              color: Colors.pink
          ),
          title: Text("Hala\'s Shopping List"),
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: mnBlue),
//        ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart, color: mnBlue,),
              onPressed: _getShoppingList,
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: _buildShoppingListItem,
              itemCount: _shoppingList.length, // you can eliminate this param to make it infinite
            )
        )
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( _shoppingList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }
}
