import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:scanly_ios/screens/recommendations/recommendationsList.dart';

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
  List<String> _shoppingList = [ "milk", "eggs", "bread", "apples", "oranges" ];
  List<String> _recommendationsList = [ "milk", "eggs", "bread", "apples", "oranges" ];
  String _user = "";

  void setUser(String userName) {
    setState(() {
//      print("got here");
      _user = userName;
      print("the set username is " + userName );
    });
  }

  _getShoppingList() async {
    // make GET request
    print("i get here");
    String url = "$_baseUrl/getShoppingList?name=$_user";
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
//    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _shoppingList = localList;
      });
//    });
  }

  _getRecommendationsList() async {
    // make GET request
    print("i get to the recommendations getter");
    String url = "$_baseUrl/getShoppingRecommendations?name=$_user";
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
//      if (listItem["showOnList"]) {
        localList.add(listItem["name"]);
//      }
    }
//    map["result"].map((listItem) => listItem["name"] as String).toList();
    print(localList);
//    Future.delayed(const Duration(milliseconds: 3000), () {
    setState(() {
      _recommendationsList = localList;
    });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
              _getShoppingList();
              Future.delayed(const Duration(milliseconds: 1200), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingList(
//                        key: ,
                        indigoBlue: _indigoBlue,
                        goldenRod: _goldenRod,
//                        baseUrl: _baseUrl,
                        user: _user,
                        shoppingList : _shoppingList,
                    )
                  ),
                );
              });
            },
          ),
          IconButton(
          icon: Icon(Icons.receipt, color: _indigoBlue,),
          onPressed: _user == "" || _user == "no one"
                ? () => setUser("no one")
                : () {
                  _getRecommendationsList();
                  Future.delayed(const Duration(milliseconds: 12000), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecommendationsList(
                        indigoBlue: _indigoBlue,
                        goldenRod: _goldenRod,
                        // baseUrl: _baseUrl,
                        user: _user,
                        recommendationsList : _recommendationsList,
                      )
                    ),
                  );
                });
            }
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
          Center(
//          Padding(
//              padding: EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/Scanly_logo_01.png',
                width: 300,
                height: 400,
//                colorBlendMode: ,
              )
          ),
          Center(
            child: _user == "no one"
             ? Text(
                "PLEASE LOGIN ",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
//                  decorationStyle: TextDecorationStyle.wavy,
                )
            )
                : Text("")
          ),
          Padding(
          padding: EdgeInsets.all(20),
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
          Padding(
            padding: EdgeInsets.all(20),
//          Center(
            child: ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: _goldenRod,
                textColor: _indigoBlue,
                child: Text('Logout'),
                onPressed: () => setUser(""),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
