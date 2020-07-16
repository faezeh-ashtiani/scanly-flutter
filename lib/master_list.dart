import 'package:flutter/material.dart';

class MasterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
          title: Text('User\'s list'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add),
            onPressed: () {},
            ),
          ]
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
}

