import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class Scan extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
//  final String baseUrl;
  final String user;
//  File image;
//  List<String> scannedList;
  Future<List<String>> scannedListFuture;

  Scan({
    this.indigoBlue,
    this.goldenRod,
//    this.baseUrl,
    this.user,
//    this.image,
//    this.scannedList,
    this.scannedListFuture,
  });

  @override
  State<StatefulWidget> createState() => _ScanState(this.scannedListFuture);
}

class _ScanState extends State<Scan> {
  Future<List<String>> scannedListFuture;
  _ScanState(this.scannedListFuture) {
    scannedListFuture.then((List<String> scannedList) {
      setState(() {
        _scannedList = scannedList;
      });
    });
  }

//  File _image;
//  final _picker = ImagePicker();
//  int _statusCode;
  List<String> _scannedList;


//
//  Future getImage() async {
//    final pickedFile = await _picker.getImage(source: ImageSource.camera);
//
//    setState(() {
//      widget.image = File(pickedFile.path);
////      _image = File(pickedFile.path);
//    });
////    print(_image);
//    print(widget.image);
//  }
//
//  Future _makePostRequest() async {
//
////    print(widget.user);
//    String url = "${widget.baseUrl}/ocrImage";
////    String url = 'https://scanly-ada.herokuapp.com/ocrImage';
//    final request = http.MultipartRequest('post', Uri.parse(url));
//    request.fields['name'] = widget.user;
////    request.files.add(await http.MultipartFile.fromPath('file', _image.path));
//    request.files.add(await http.MultipartFile.fromPath('file', widget.image.path));
//    http.StreamedResponse response = await request.send();
//    print(response);
//    // response is an instance of StreamedResponse
//
//
//    setState(() {
//      _statusCode = response.statusCode;
//    });
//
//    print(response.statusCode);
//
//    String rawJson = await response.stream.bytesToString();
//    print(rawJson);
//
//    Map<String, dynamic> map = jsonDecode(rawJson);
//    print(map);
//
//    List<String> localList = [];
//    for (var listItem in map["products"]) {
//        localList.add(listItem["name"]);
//    }
////    map["result"].map((listItem) => listItem["name"] as String).toList();
//    print(localList);
////    Future.delayed(const Duration(milliseconds: 3000), () {
//    setState(() {
//      _scannedList = localList;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.indigoBlue,
      appBar: AppBar(
        backgroundColor: widget.indigoBlue,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: widget.goldenRod
        ),
        title: Text(
          "Scanner",
          style: TextStyle(

            color: widget.goldenRod,
          ),
        ),
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
        padding: EdgeInsets.all(5),
//        width: double.infinity,
        child: _scannedList == null
          ? Center(
            child: CircularProgressIndicator(),
          )
//          ? Column(
//              children: <Widget>[
//  //              CircularProgressIndicator(),
//                Padding(
//                  padding: EdgeInsets.all(20),
//  //            Center(
////                 child: Image.file(widget.image)
////                child: _scannedList == null
////                // child: _scannedList == null
////                    ? Image.file(widget.image)
////  //                  : Image.file(_image),
////                    : ListView.builder(
////                      itemBuilder: _buildListItem,
////                      itemCount: _scannedList.length, // you can eliminate this param to make it infinite
////                ),
//              ),
//               RaisedButton(
//                  onPressed: _makePostRequest,
//                  color: Colors.pink,
//                  textColor: Colors.white,
//                  child: Text('CONFIRM'),
//               ),
//              _scannedList == null
//  //                ? Text('')
//                  ? RaisedButton(
//                    onPressed: _makePostRequest,
//                    color: Colors.pink,
//                    textColor: Colors.white,
//                    child: Text('CONFIRM'),
//                  )
//                  : Text('')

  //            Center(
  //              child: _statusCode == null
  //                  ? Text('')
  //                  : Text(_statusCode.toString()),
  //            )
//            ],
//          )
            : ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: _scannedList.length, // you can eliminate this param to make it infinite
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

  Widget _buildListItem( BuildContext context, int index ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( _scannedList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }

}

