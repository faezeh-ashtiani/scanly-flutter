import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

//import './camera.dart';

void main() {
  Future main() async {
    await DotEnv().load('.env');
  }

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => ThirdRoute()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.pink,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCustomForm()),
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
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SecondRouteState();
  }
}

class _SecondRouteState extends State<SecondRoute> {
//class SecondRoute extends StatelessWidget {

  File _image;
  final _picker = ImagePicker();
//  Quote _quoteOfTheDay;
  int _statusCode;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    print(_image);
  }

  Future _makeGetRequest() async {
    // make GET request
    String url = 'https://api.imgur.com/3/upload';
    final request = http.MultipartRequest('post', Uri.parse(url));
    request.fields['type'] = 'file';
    request.files.add(await http.MultipartFile.fromPath('image', _image.path));
    request.headers['Authorization'] = DotEnv().env['IMGUR_AUTHORIZATION_KEY'];
//    'Authorization: Bearer 5eeae49394cd929e299785c8805bd168fc675280' // this only works for a month from July 9
//    DotEnv().env['VAR_NAME'];
    http.StreamedResponse response = await request.send();
    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String rawJson = await response.stream.bytesToString();
//
    Map<String, dynamic> map = jsonDecode(rawJson);
//    String quote = map["contents"]["quotes"][0]["quote"];
//    String author = map["contents"]["quotes"][0]["author"];
//
//    setState(() {
//      _quoteOfTheDay = Quote(quote, author);
//      _statusCode = statusCode;
//    });

    print(statusCode);
    print(rawJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        iconTheme: IconThemeData(
          color: Colors.pink
        ),
        title: Text("Scanner"),
      ),
//      body: Stack(
//        children: <Widget>[
//          Center(
//            child: SizedBox(
//              height: 450.0,
//              width: 300.0,
//              child: Card(
//                elevation: 1.0,
//              ),
//            ),
//          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Padding(
//              padding: const EdgeInsets.all(40.0),
//              child: ButtonTheme(
//                  minWidth: 200.0,
//                  height: 70.0,
//                  child: RaisedButton.icon(
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                  color: Colors.pink,
//                  textColor: Colors.white,
//                  icon: Icon(Icons.image),
//                  label: Text('SCAN')
//                  ),
//              ),
//            ),
//          ),
//        ],
//      )
      body: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
//            Expanded(
//                child: Text('Camera Screen to show here'),
//            ),
//            SizedBox(
//              height: 600.0,
//              width: 300.0,
//              child: Card(
//                elevation: 1.0,
//              ),
//            ),
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            _image == null
            ? RaisedButton.icon(
//                onPressed: () {
//                  Navigator.pop(context);
//                },
                onPressed: getImage,
                color: Colors.pink,
                textColor: Colors.white,
                icon: Icon(Icons.image),
                label: Text('SCAN')
            )
            : RaisedButton(
              onPressed: _makeGetRequest,
              color: Colors.pink,
              textColor: Colors.white,
              child: Text('USE'),
            ),
          ],
        ),
      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('!'),
//        ),
//      ),
    );
  }
}


class ThirdRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ThirdRouteState();
  }
}

class _ThirdRouteState extends State<ThirdRoute> {
  final List<String> fruits = [ "Apple", "Banana", "Pear", "Orange", "Kiwi" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
              color: Colors.pink
          ),
          title: Text("User\'s Shopping List"),
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: _buildShoppingListItem,
              itemCount: fruits.length, // you can eliminate this param to make it infinite
            )
        )
    );
  }

  Widget _buildShoppingListItem( BuildContext context, int index ){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( fruits[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }
}

//// this was initially setup for the quote of the day api
//class Quote {
//  Quote(this.quote, this.author);
//  final String quote;
//  final String author;
//}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
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
    print(myController.text);
//    return showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          // Retrieve the text the that user has entered by using the
//          // TextEditingController.
//          content: Text(myController.text),
//        );
//      },
//    );

    // make Post request
    String url = 'http://localhost:8081/createUser';
    final request = http.MultipartRequest('post', Uri.parse(url));
    request.fields['text'] = myController.text;
//    request.files.add(await http.MultipartFile.fromPath('image', _image.path));
//    request.headers['Authorization'] = DotEnv().env['IMGUR_AUTHORIZATION_KEY'];
//    'Authorization: Bearer 5eeae49394cd929e299785c8805bd168fc675280' // this only works for a month from July 9
//    DotEnv().env['VAR_NAME'];
    http.StreamedResponse response = await request.send();
    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String rawJson = await response.stream.bytesToString();
//
    Map<String, dynamic> map = jsonDecode(rawJson);
//    String quote = map["contents"]["quotes"][0]["quote"];
//    String author = map["contents"]["quotes"][0]["author"];
//
//    setState(() {
//      _quoteOfTheDay = Quote(quote, author);
//      _statusCode = statusCode;
//    });

    print(statusCode);
    print(rawJson);
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
      floatingActionButton: FloatingActionButton(

        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: _sendUserInfo,
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

