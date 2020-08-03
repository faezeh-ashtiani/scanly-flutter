import 'package:flutter/material.dart';

class Scan extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String user;
  Future<List<String>> scannedListFuture;

  Scan({
    this.indigoBlue,
    this.goldenRod,
    this.user,
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

  List<String> _scannedList;

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
      body: Container(
        padding: EdgeInsets.all(5),
//        width: double.infinity,
        child: _scannedList == null
        ? Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              valueColor: // _colorTween,
              AlwaysStoppedAnimation<Color>(widget.goldenRod),
              strokeWidth: 30,
            ),
            height: 150,
            width: 150,
          ),
        )
        : ListView.builder(
            itemBuilder: _buildListItem,
            itemCount: _scannedList.length, // you can eliminate this param to make it infinite
        ),
      ),
    );
  }

  Widget _buildListItem( BuildContext context, int index ) {
    return Card(
      color: widget.goldenRod,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( _scannedList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }

}

