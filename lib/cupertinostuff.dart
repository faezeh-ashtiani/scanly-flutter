//this woudl be the scan file:
//
//import 'package:flutter/material.dart';
//
//class Scan extends StatefulWidget {
//  static const routeName = '/add-image';
//  @override
//  _ScanState createState() => _ScanState();
//}
//
//class _ScanState extends State<Scan> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Scan your Receipt!'),
//      ),
//      body: Column(
//        children: <Widget>[
//          Text('Camera Screen to show here'),
//          RaisedButton.icon(
//              onPressed: null,
//              icon: Icon(Icons.image),
//              label: Text('SCAN')
//          ),
//        ],
//      ),
//    );
//  }
//}



//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//
//import 'screens//scann.dart'; // I am changing the name to delete that file - take our the extra n
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//
//  // This widget is the root of your application.
////  @override
//  Widget build(BuildContext context) {
//    return CupertinoApp(
////      theme: CupertinoThemeData(
////        textTheme: CupertinoTextThemeData(
////          navLargeTitleTextStyle: TextStyle(
////            fontWeight: FontWeight.bold,
////            fontSize: 60,
////            color: CupertinoColors.activeBlue
////          ),
////        )
////      ),
//      home: HomeScreen(),
//    );
//  }
//}
//
//void takeImage() {
//  print('Image not figured out yet!');
//}
//
//class HomeScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return CupertinoPageScaffold(
//      child: Center(
//        child: CupertinoButton(
//            child: Text('Scan Receipt'),
////              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle, ),
//            onPressed: takeImage,
//            color: CupertinoColors.systemPink,
//            borderRadius: BorderRadius.all(Radius.zero),
//        ),
//      ),
//    );
//  }
//}
