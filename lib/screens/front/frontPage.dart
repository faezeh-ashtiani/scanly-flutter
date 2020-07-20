import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../screens/scan/scan.dart';
import '../../screens/list/shoppingList.dart';
import '../../screens/login/loginForm.dart';

class FrontPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FrontPageState();
  }
}

class _FrontPageState extends State<FrontPage> {
  final indigoBlue = Color(0xff242A64);
  final goldenRod = Color(0xffFCAE17);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: chineseYellow,
      appBar: AppBar(
        backgroundColor: goldenRod,
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: mnBlue),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: indigoBlue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: indigoBlue,),
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
                'assets/images/Scanly_logo_01.png',
                width: 300,
                height: 400,
//                colorBlendMode: ,
              )
          ),
          Center(
            child: ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: indigoBlue,
                textColor: goldenRod,
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
