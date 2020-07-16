import 'package:flutter/material.dart';

import '../../screens/scan/scan.dart';
import '../../screens/list/shoppingList.dart';
import '../../screens/login/loginForm.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
//        iconTheme: IconThemeData(
//            color: Colors.pink
//        ),
        title: Text('Scanly'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.pink,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.pink,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ButtonTheme(
          minWidth: 100.0,
          height: 50.0,
          child: RaisedButton(
            color: Colors.pink,
            textColor: Colors.white,
            child: Text('Scan Receipt'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scan()),
              );
            },
          ),
        ),
      ),
    );
  }
}
