import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';


class ShoppingList extends StatefulWidget {
//  final Key key;
  final Color indigoBlue;
  final Color goldenRod;
  final String baseUrl;
  final String user;
  List<String> shoppingList;


  ShoppingList({
//    this.key,
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


  // Create a text controller and use it to retrieve the current value
  // of the TextField.
//  final myController = TextEditingController();
//
//  @override
//  void dispose() {
//    // Clean up the controller when the widget is disposed.
//    myController.dispose();
//    super.dispose();
//  }
//
//  Future _sendUserInfo() async {
//
//    Map<String, dynamic> map = {
//      'name': myController.text,
//    };
//    String newJson = jsonEncode(map);
//
//    String url = "${widget.baseUrl}/createUser";
//    Map<String, String> requestHeaders = {"Content-type": "application/json"};
//    final response = await http.post(url, headers: requestHeaders, body: newJson);
//
//    // sample info available in response
//    int _statusCode = response.statusCode;
//    Map<String, String> headers = response.headers;
//    String responseText = response.body;
//    print(_statusCode);
//    print(responseText);
//
//    widget.setUser(responseText);
//    Navigator.pop(context);
//  }
//  List<String> _shoppingList = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];
//


  _removeFromList(int index) async {
    print("i am deleting from list");

    final item = widget.shoppingList[index];
    String url = "${widget.baseUrl}/deleteProductFromShoppingList?user=${widget.user}&product=$item";

    Response response = await patch(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    print(json);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.goldenRod,
        iconTheme: IconThemeData(
            color: widget.indigoBlue
        ),
        title: Text(
            "${widget.user}\'s Shopping List",
            style: TextStyle(
            fontSize: 18.0,
            color: widget.indigoBlue,
          ),
        ),
//        elevation: 0.0,
      ),
      body:
      Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: _buildDismissibleListItem,
            itemCount: widget.shoppingList.length, // you can eliminate this param to make it infinite
          )
      ),
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( widget.shoppingList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }

  Widget _buildDismissibleListItem(BuildContext context, int index) {
    final item = widget.shoppingList[index];

    return Dismissible(
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: Key(item),
      // Provide a function that tells the app
      // what to do after an item has been swiped away.
      onDismissed: (direction) {

        _removeFromList(index);
        setState(() {
          widget.shoppingList.removeAt(index);
        });

        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("$item deleted")));
      },
      // Show a red background as the item is swiped away.
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
//      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            item, style: TextStyle(fontSize: 22.0), ),
        ),
//      )
    );
  }

}
