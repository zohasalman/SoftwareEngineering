import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'userRedirection.dart';
import 'package:rating_bar/rating_bar.dart' ;

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {

    final items = Provider.of<List<Item>>(context);
    if (items == null){
      return LoadingScreen();
    }else{
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index){
          return Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 20.0),
                        child: Image.network('${items[index].logo}', height: 25.0, width: 25.0,), 
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 0.0, left: 20.0),
                          child: Text('${items[index].name}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar.readOnly(
                          initialRating: double.parse('${items[index].aggregateRating}'),
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            );
      });
    }
  }
}