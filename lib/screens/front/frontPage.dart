import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../screens/scan/scan.dart';
import '../../screens/list/shoppingList.dart';
import '../../screens/login/loginForm.dart';

class FrontPage extends StatelessWidget {
  final mnBlue = Color(0xff34558B);
  final chineseYellow = Color(0xffffb41f);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: chineseYellow,
      appBar: AppBar(
        backgroundColor: chineseYellow,
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: mnBlue),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: mnBlue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: mnBlue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(
                'assets/images/shopping_cart.png',
                width: 250,
                height: 250,
//                colorBlendMode: ,
              )
          ),
          Center(
            child: ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: mnBlue,
                textColor: chineseYellow,
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
        ],
      ),
    );
  }
}
