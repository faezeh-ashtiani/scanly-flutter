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
  Quote _quoteOfTheDay;
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
//            _statusCode == 200
//            ? Text(_quoteOfTheDay.quote)
//            : Container(
//              height: 0,
//              width: 0,
//            ),
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

class Quote {
  Quote(this.quote, this.author);
  final String quote;
  final String author;
}