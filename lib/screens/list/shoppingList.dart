import 'package:flutter/material.dart';
import 'package:http/http.dart';


class ShoppingList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final mnBlue = Color(0xff34558B);
  final chineseYellow = Color(0xffffb41f);

  List<String> shopingList;

  _getShoppingList() async {
    // make GET request
    String url = 'http://192.168.0.11:8080/getShoppingList?name=hala';
    Response response = await get(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    setState(() {
//      shopingList = response.body;
    });
//    Map<String, String> headers = response.headers;
//    String contentType = headers['content-type'];
//    String json = response.body;
  }

  final List<String> fruits = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

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
              itemCount: shopingList.length, // you can eliminate this param to make it infinite
            )
        )
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( shopingList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }
}
