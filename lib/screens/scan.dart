import 'package:flutter/material.dart';

class Scan extends StatefulWidget {
  static const routeName = '/add-image';
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan your Receipt!'),
      ),
      body: Column(
        children: <Widget>[
          Text('Camera Screen to show here'),
          RaisedButton.icon(
              onPressed: null,
              icon: Icon(Icons.image),
              label: Text('SCAN')
          ),
        ],
      ),
    );
  }
}