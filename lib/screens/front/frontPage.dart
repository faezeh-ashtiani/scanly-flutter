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
  final _indigoBlue = Color(0xff242A64);
  final _goldenRod = Color(0xffFCAE17);
  final _baseUrl = "http://192.168.0.11:8080";

  String _user = "";

  void setUser(String userName) {
    setState(() {
//      print("got here");
      _user = userName;
      print("the set username is " + userName );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: _goldenRod,
      appBar: AppBar(
        backgroundColor: _goldenRod,
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: _indigoBlue),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: _indigoBlue,),
            onPressed: _user == "" || _user == "no one"
                    ? () => setUser("no one")
                    : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList(
                      indigoBlue: _indigoBlue,
                      goldenRod: _goldenRod,
                      baseUrl: _baseUrl,
                      user: _user,
                  )
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: _indigoBlue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm(
                      indigoBlue: _indigoBlue,
                      goldenRod: _goldenRod,
                      baseUrl: _baseUrl,
                      setUser: setUser,
                  )
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(40),
              child: Image.asset(
                'assets/images/Scanly_logo_01.png',
                width: 300,
                height: 400,
//                colorBlendMode: ,
              )
          ),
          Center(
            child: _user == "no one"
             ? Text("Please First LogIn ")
                : Text("")
          ),
          Padding(
          padding: EdgeInsets.all(40),
//          Center(
            child: ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: _indigoBlue,
                textColor: _goldenRod,
                child: Text('Scan Receipt'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scan(
                        indigoBlue: _indigoBlue,
                        goldenRod: _goldenRod,
                        baseUrl: _baseUrl,
                        user: _user,
                      )
                    ),
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
