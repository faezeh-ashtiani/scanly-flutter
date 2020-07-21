import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String baseUrl;
  final Function setUser;

  LoginForm({
    this.indigoBlue,
    this.goldenRod,
    this.baseUrl,
    this.setUser,
  });

  @override
  _LoginFormState createState() => _LoginFormState(
  );
}

class _LoginFormState extends State<LoginForm> {

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future _sendUserInfo() async {

    Map<String, dynamic> map = {
      'name': myController.text,
    };

    String newJson = jsonEncode(map);

    String url = "${widget.baseUrl}/createUser";
    Map<String, String> requestHeaders = {"Content-type": "application/json"};

    final response = await http.post(url, headers: requestHeaders, body: newJson);

    // sample info available in response
    int _statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String responseText = response.body;

    print(_statusCode);
    print(responseText);
    widget.setUser(responseText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(25),
        child: RaisedButton(
          color: Colors.pink,
          textColor: Colors.white,
          child: Text('Login'),
          onPressed: _sendUserInfo,
        ),
      ),

//      floatingActionButton: FloatingActionButton(
//
//        onPressed: _sendUserInfo,
//        child: Icon(Icons.text_fields),
//        backgroundColor: Colors.pink,
//      ),
    );
  }
}
