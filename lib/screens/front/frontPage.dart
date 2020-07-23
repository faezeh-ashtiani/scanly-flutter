import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:scanly_ios/screens/recommendations/recommendationsList.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../screens/scan/scan.dart';
import '../../screens/list/shoppingList.dart';
import '../../screens/recommendations/recommendationsList.dart';
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
  final _baseUrl = "http://192.168.86.34:8080";
  List<String> _shoppingList = ["milk", "eggs", "bread", "apples", "oranges"];
  List<String> _recommendationsList = ["milk", "eggs", "bread", "apples", "oranges"];
  Future<List<String>> recommendationsListFuture;
  String _user = "";
  File _image;
  int _photoStatusCode;
  Future<List<String>> scannedListFuture;

  void setUser(String userName) {
    setState(() {
      _user = userName;
      print("the set username is " + userName);
    });
  }

  void setShoppingList(List<String> shoppingList) {
    setState(() {
      _shoppingList = shoppingList;
    });
  }

  Future<List<String>> _makePostRequest() async {
    String url = "$_baseUrl/ocrImage";
    final request = http.MultipartRequest('post', Uri.parse(url));
    request.fields['name'] = _user;
    // request.files.add(await http.MultipartFile.fromPath('file', _image.path));
    request.files.add(await http.MultipartFile.fromPath('file', _image.path));
    http.StreamedResponse response = await request.send();
    print(response);
    // response is an instance of StreamedResponse

    setState(() {
      _photoStatusCode = response.statusCode;
    });

    print(_photoStatusCode);

    String rawJson = await response.stream.bytesToString();
    print("this is rawJson" + rawJson);


    Map<String, dynamic> map = jsonDecode(rawJson);
//    print("this is map" + map.toString());

    List<String> localList = [];
    for (var listItem in map["products"]) {
      localList.add(listItem["name"]);
    }

//    print(localList);

    //    setState(() {
    //      _scannedList = localList;
    //    });
    return localList;
  }

  _getShoppingList() async {
    // make GET request
    print("getting shopping list");
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
    setShoppingList(localList);

  }

  Future<List<String>> _getRecommendationsList() async {
    // make GET request
    print("getting the reccomendations");
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
      localList.add(listItem["name"]);
    }
    //    map["result"].map((listItem) => listItem["name"] as String).toList();
    print(localList);
//    setState(() {
//      _recommendationsList = localList;
//    });
    return localList;
  }

  final _picker = ImagePicker();

  Future<List<String>> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });

    print(_image);

    return _makePostRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _goldenRod,
      appBar: AppBar(
        backgroundColor: _goldenRod,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: _indigoBlue,
            ),
            onPressed: _user == "" || _user == "no one"
                ? () => setUser("no one")
                : () async {
                    await _getShoppingList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingList(
                                indigoBlue: _indigoBlue,
                                goldenRod: _goldenRod,
                                baseUrl: _baseUrl,
                                user: _user,
                                shoppingList: _shoppingList,
                              )
                      ),
                    );
                  },
          ),
          IconButton(
              icon: Icon(
                Icons.receipt,
                color: _indigoBlue,
              ),
              onPressed: _user == "" || _user == "no one"
                  ? () => setUser("no one")
                  : ()  {
                      recommendationsListFuture = _getRecommendationsList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecommendationsList(
                                  indigoBlue: _indigoBlue,
                                  goldenRod: _goldenRod,
                                  baseUrl: _baseUrl,
                                  user: _user,
//                                  recommendationsList: _recommendationsList,
                                  setShoppingList: setShoppingList,
//                                  shoppingList: _shoppingList,
                                  recommendationsListFuture : recommendationsListFuture,
                            )
                        ),
                      );
                    }),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: _indigoBlue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginForm(
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
              child: Image.asset(
                'assets/images/Scanly_logo_02.png',
                width: 300,
                height: 400,
              )
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: _indigoBlue,
                textColor: Colors.white,
                child: Text('Scan Receipt'),
                onPressed: _user == "" || _user == "no one"
                    ? () => setUser("no one")
                    : () {
                        scannedListFuture = _getImage();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scan(
                                    indigoBlue: _indigoBlue,
                                    goldenRod: _goldenRod,
                                    user: _user,
                                    scannedListFuture: scannedListFuture,
                                  )
                          ),
                        );
                      },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: _user == "" || _user == "no one"
                  ? _user == ""
                      ? ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white,
                            textColor: _indigoBlue,
                            child: Text('Login'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginForm(
                                          indigoBlue: _indigoBlue,
                                          goldenRod: _goldenRod,
                                          baseUrl: _baseUrl,
                                          setUser: setUser,
                                        )
                                ),
                              );
                            },
                          ),
                        )
                      : ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('Login'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginForm(
                                          indigoBlue: _indigoBlue,
                                          goldenRod: _goldenRod,
                                          baseUrl: _baseUrl,
                                          setUser: setUser,
                                        )
                                ),
                              );
                            },
                          ),
                        )
                  : ButtonTheme(
                      minWidth: 100.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: _indigoBlue,
                        child: Text('Logout'),
                        onPressed: () => setUser(""),
                      ),
                    )
              ),
        ],
      ),
    );
  }
}
