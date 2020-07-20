import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class Scan extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String baseUrl;

  Scan({
    this.indigoBlue,
    this.goldenRod,
    this.baseUrl,
  });

  @override
  State<StatefulWidget> createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  File _image;
  final _picker = ImagePicker();
  int _statusCode;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    print(_image);
  }



  Future _makePostRequest() async {
    String url = "${widget.baseUrl}/ocrImage";
//    String url = 'https://scanly-ada.herokuapp.com/ocrImage';
    final request = http.MultipartRequest('post', Uri.parse(url));
    request.fields['name'] = 'faezeh';
    request.files.add(await http.MultipartFile.fromPath('file', _image.path));
    http.StreamedResponse response = await request.send();
    print(response);
    // response is an instance of StreamedResponse

    setState(() {
      _statusCode = response.statusCode;
    });

    print(response.statusCode);

//    String rawJson = await response.stream.bytesToString();
//    print(rawJson);

//    Map<String, dynamic> map = jsonDecode(rawJson);
//    print(map);
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
//            Center(
//              child: Container(
//                  margin: const EdgeInsets.all(10.0),
//                  color: Colors.amber[600],
//                  width: 48.0,
//                  height: 48.0,
//
//              ),
//            ),
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
              onPressed: _makePostRequest,
              color: Colors.pink,
              textColor: Colors.white,
              child: Text('USE'),
            ),
            Center(
              child: _statusCode == null
                  ? Text('')
                  : Text('Successfully Scanned'),
            )
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

