import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class ShoppingList extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String baseUrl;
  final String user;
  List<String> shoppingList;

  ShoppingList({
    this.indigoBlue,
    this.goldenRod,
    this.baseUrl,
    this.user,
    this.shoppingList,
  });

  @override
  State<StatefulWidget> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

//  List<String> _shoppingList = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];
//
//  _getShoppingList() async {
////    print(widget.user);
//    // make GET request
//    print("i get here");
//    String url = "${widget.baseUrl}/getShoppingList?name=${widget.user}";
////    String url = "https://scanly-ada.herokuapp.com/getShoppingList?name=hala";
//    Response response = await get(url);
//    // sample info available in response
//    int statusCode = response.statusCode;
//    print(statusCode);
//
//    String json = response.body;
//    print(json);
//    Map<String, dynamic> map = jsonDecode(json);
////    print(map);
//    print(map["result"][0]["name"]as String);
////    Iterable<String> testList = map["result"].map((listItem) {
////      return listItem["name"] as String;
////    } as String);
//
//    List<String> localList = [];
//    for (var listItem in map["result"]) {
//      localList.add(listItem["name"]);
//    }
////    map["result"].map((listItem) => listItem["name"] as String).toList();
//    print(localList);
//    setState(() {
//      _shoppingList = localList;
//    });
//  }
//
//  final List<String> fruits = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.goldenRod,
          iconTheme: IconThemeData(
              color: Colors.pink
          ),
          title: Text("${widget.user}\'s Shopping List"),
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: mnBlue),
//        ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.shopping_cart, color: widget.indigoBlue,),
//              onPressed: _getShoppingList,
//            ),
//          ],
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: _buildShoppingListItem,
              itemCount: widget.shoppingList.length, // you can eliminate this param to make it infinite
            )
        )
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( widget.shoppingList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }
}
