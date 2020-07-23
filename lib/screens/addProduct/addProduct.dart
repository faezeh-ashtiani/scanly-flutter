import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';
import '../../screens/list/shoppingList.dart';

// Define a custom Form widget.
class addProduct extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String baseUrl;
  final String user;

  addProduct({
    this.indigoBlue,
    this.goldenRod,
    this.baseUrl,
    this.user,
  });

  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future _sendProductInfo() async {
    Map<String, dynamic> map = {
      'product': myController.text,
    };
    String newJson = jsonEncode(map);

    String url =
        "${widget.baseUrl}/createShoppingListProduct?user=${widget.user}&product=${myController.text}";
    Map<String, String> requestHeaders = {"Content-type": "application/json"};
    final response =
        await http.post(url, headers: requestHeaders, body: newJson);

    // sample info available in response
    int _statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String responseText = response.body;
    print(_statusCode);
    print(responseText);
    await _getShoppingList();
    Navigator.pop(context, MaterialPageRoute(
        builder: (context) => ShoppingList()));
  }

  List<String> _shoppingList;
  void setShoppingList(List<String> shoppingList) {
    setState(() {
      _shoppingList = shoppingList;
    });
  }

  _getShoppingList() async {
    // make GET request
    print("getting shopping list");
    String url = "${widget.baseUrl}/getShoppingList?name=${widget.user}";
    Response response = await get(url);

    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    //    print(json);
    Map<String, dynamic> map = jsonDecode(json);
    //    print(map);
    //    print(map["result"][0]["name"]as String);
    //    Iterable<String> testList = map["result"].map((listItem) {
    //      return listItem["name"] as String;
    //    } as String);

    List<String> localList = [];
    for (var listItem in map["result"]) {
      if (listItem["showOnList"]) {
        localList.add(listItem["name"]);
      }
    }
    //    map["result"].map((listItem) => listItem["name"] as String).toList();
    print(localList);
    await setShoppingList(localList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.goldenRod,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: widget.indigoBlue,
          ),
          title: Text(
            'Add Product',
            style: TextStyle(
              fontSize: 24.0,
              color: widget.indigoBlue,
            ),
          ),
          backgroundColor: widget.goldenRod,
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(60),
              child: TextField(
                controller: myController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ButtonTheme(
                minWidth: 100.0,
                height: 50.0,
                child: RaisedButton(
                  color: widget.indigoBlue,
                  textColor: widget.goldenRod,
                  child: Text('Add Product to Shopping List'),
                  onPressed: _sendProductInfo,
                ),
              ),
            ),
          ],
        )
//      body: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: TextField(
//          controller: myController,
//        ),
//      ),
//      floatingActionButton: Padding(
//        padding: EdgeInsets.all(25),
//        child: ButtonTheme(
//          minWidth: 100.0,
//          height: 50.0,
//          child: RaisedButton(
//            color: widget.indigoBlue,
//            textColor: widget.goldenRod,
//            child: Text('Login'),
//            onPressed: _sendUserInfo,
//          ),
//        ),
//      ),

        );
  }
}
