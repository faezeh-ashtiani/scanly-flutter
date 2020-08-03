import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../screens/addProduct/addProduct.dart';

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
      backgroundColor: Colors.white,
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
        actions: <Widget>[
          IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: widget.indigoBlue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProduct(
                    indigoBlue: widget.indigoBlue,
                    goldenRod: widget.goldenRod,
                    baseUrl: widget.baseUrl,
                    user: widget.user,
                  )
                ),
              );
            },
          ),
        ],
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
      //  child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            item, style: TextStyle(fontSize: 22.0),  ),
        ),
      //  )
    );
  }

  // not used
  Widget _buildShoppingListItem( BuildContext context, int index ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( widget.shoppingList[index], style: TextStyle(fontSize: 22.0, color: Colors.white), ),
      ),
    );
  }

}
