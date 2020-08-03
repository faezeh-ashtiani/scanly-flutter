import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../screens/list/shoppingList.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RecommendationsList extends StatefulWidget {
  final Color indigoBlue;
  final Color goldenRod;
  final String user;
  final String baseUrl;
  final Function setShoppingList;
  Future<List<String>> recommendationsListFuture;

  RecommendationsList({
    this.indigoBlue,
    this.goldenRod,
    this.user,
    this.recommendationsListFuture,
    this.baseUrl,
    this.setShoppingList,
  });

  @override
  State<StatefulWidget> createState() =>
      _RecommendationsListState(this.recommendationsListFuture);
}

class _RecommendationsListState extends State<RecommendationsList> {
  Future<List<String>> recommendationsListFuture;

  _RecommendationsListState(this.recommendationsListFuture) {
    recommendationsListFuture.then((List<String> recommendationsList) {
      setState(() {
        _recommendationsList = recommendationsList;
      });
    });
  }

  List<String> _recommendationsList;

  _removeFromList(int index) async {
    print("i am deleting from list");

    final item = _recommendationsList[index];
    String url =
        "${widget.baseUrl}/updateUserRecommendationProduct?user=${widget.user}&product=$item";

    Response response = await patch(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    print(json);
  }

  _addToShoppingList(int index) async {
    print("i am adding to shopping list");

    final item = _recommendationsList[index];
    String url =
        "${widget.baseUrl}/addUserRecommendationProduct?user=${widget.user}&product=$item";

    Response response = await patch(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    print(json);
  }

  List<String> _shoppingList;
  void setShoppingList(List<String> shoppingList) {
    setState(() {
      _shoppingList = shoppingList;
    });
  }

  _getShoppingList() async {
    // make GET request
    print("getting shopping list");
    String url = "${widget.baseUrl}/getShoppingList?name=${widget.user}";
    Response response = await get(url);

    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    Map<String, dynamic> map = jsonDecode(json);

    List<String> localList = [];
    for (var listItem in map["result"]) {
      if (listItem["showOnList"]) {
        localList.add(listItem["name"]);
      }
    }
    print(localList);
    setShoppingList(localList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.goldenRod,
      appBar: AppBar(
        backgroundColor: widget.indigoBlue,
        iconTheme: IconThemeData(color: widget.goldenRod),
        title: Text(
          "Recommendations for ${widget.user}",
          style: TextStyle(
            fontSize: 18.0,
            color: widget.goldenRod,
          ),
        ),
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: widget.goldenRod,
            ),
            onPressed: () async {
              await _getShoppingList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingList(
                    // key: ,
                    indigoBlue: widget.indigoBlue,
                    goldenRod: widget.goldenRod,
                    baseUrl: widget.baseUrl,
                    user: widget.user,
                    shoppingList: _shoppingList,
                  )
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: _recommendationsList == null
        ? Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              valueColor: // _colorTween,
                  AlwaysStoppedAnimation<Color>(widget.indigoBlue),
              strokeWidth: 30,
            ),
            height: 150,
            width: 150,
          ),
        )
        : ListView.builder(
          itemBuilder: _buildSlidableListItem,
          itemCount: _recommendationsList
              .length, // you can eliminate this param to make it infinite
        )
      ),
    );
  }

  Widget _buildSlidableListItem(BuildContext context, int index) {
    final item = _recommendationsList[index];

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          item,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
      // actions: <Widget>[
      //   IconSlideAction(
      //   caption: 'Archive',
      //   color: Colors.blue,
      //   icon: Icons.archive,
      //   onTap: () {print('archive');},
      //   ),
      //   IconSlideAction(
      //   caption: 'Share',
      //   color: Colors.indigo,
      //   icon: Icons.share,
      //   onTap: () {print('share');},
      //   ),
      // ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Add',
          color: widget.indigoBlue,
          icon: Icons.add,
          onTap: () async {
            print('add');
            await _addToShoppingList(index);
            setState(() {
              _recommendationsList.removeAt(index);
            });
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            print('delete');
            _removeFromList(index);
            setState(() {
              _recommendationsList.removeAt(index);
            });

            // Then show a snackbar.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
        ),
      ],
    );
  }

}
