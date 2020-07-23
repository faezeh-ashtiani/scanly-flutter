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
  List<String> recommendationsList;
  final String baseUrl;
  final Function setShoppingList;
  List<String> shoppingList;

  RecommendationsList({
    this.indigoBlue,
    this.goldenRod,
    this.user,
    this.recommendationsList,
    this.baseUrl,
    this.setShoppingList,
    this.shoppingList,
  });

  @override
  State<StatefulWidget> createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {

  _removeFromList(int index) async {
    print("i am deleting from list");

    final item = widget.recommendationsList[index];
    String url = "${widget.baseUrl}/updateUserRecommendationProduct?user=${widget.user}&product=$item";

    Response response = await patch(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    print(json);

  }

  _addToShoppingList(int index) async {
    print("i am adding to shopping list");

    final item = widget.recommendationsList[index];
    String url = "${widget.baseUrl}/addUserRecommendationProduct?user=${widget.user}&product=$item";

    Response response = await patch(url);
    // sample info available in response
    int statusCode = response.statusCode;
    print(statusCode);

    String json = response.body;
    print(json);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.goldenRod,
        iconTheme: IconThemeData(
            color: widget.indigoBlue
        ),
        title: Text(
            "Recommendations for ${widget.user}",
            style: TextStyle(
            fontSize: 18.0,
            color: widget.indigoBlue,
          ),
        ),
//        elevation: 0.0,
//        title: Text(
//          'Scanly',
//          style: TextStyle(color: mnBlue),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: widget.indigoBlue,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList(
//                        key: ,
                  indigoBlue: widget.indigoBlue,
                  goldenRod: widget.goldenRod,
                  baseUrl: widget.baseUrl,
                  user: widget.user,
                  shoppingList : widget.shoppingList,
                )
                ),
              );
            },
          ),
        ],
      ),
      body:
      Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: _buildSlidableListItem,
            itemCount: widget.recommendationsList.length, // you can eliminate this param to make it infinite
          )
      ),
    );
  }

  Widget _buildRecommendationsListItem( BuildContext context, int index ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( widget.recommendationsList[index], style: TextStyle(fontSize: 22.0), ),
      ),
    );
  }

  Widget _buildDismissibleListItem(BuildContext context, int index) {
    final item = widget.recommendationsList[index];

    return Dismissible(
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: Key(item),
      // Provide a function that tells the app
      // what to do after an item has been swiped away.
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          widget.recommendationsList.removeAt(index);
        });

        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("$item dismissed")));
      },
      // Show a red background as the item is swiped away.
      background: Container(
//        padding: EdgeInsets.only(right: 28.0),
//        alignment: AlignmentDirectional.centerStart,
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white,),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( item, style: TextStyle(fontSize: 22.0), ),
      ),
//      ListTile(title: Text('$item')),
    );
  }

  Widget _buildSlidableListItem(BuildContext context, int index) {
    final item = widget.recommendationsList[index];

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text( item, style: TextStyle(fontSize: 22.0), ),
      ),
//      actions: <Widget>[
//        IconSlideAction(
//        caption: 'Archive',
//        color: Colors.blue,
//        icon: Icons.archive,
//        onTap: () {print('archive');},
//        ),
//        IconSlideAction(
//        caption: 'Share',
//        color: Colors.indigo,
//        icon: Icons.share,
//        onTap: () {print('share');},
//        ),
//      ],
      secondaryActions: <Widget>[
        IconSlideAction(
        caption: 'Add',
        color: widget.indigoBlue,
        icon: Icons.add,
        onTap: ()  {
          print('add');
          _addToShoppingList(index);
          setState(() {
            widget.recommendationsList.removeAt(index);
          });
          setState(() {
            widget.shoppingList.add(widget.recommendationsList[index]);
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
            widget.recommendationsList.removeAt(index);
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