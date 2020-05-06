import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/item.dart';
import 'package:rating_bar/rating_bar.dart' ;
import 'userRedirection.dart';

class DisplayItems extends StatefulWidget {

  List<Map> list;
  DisplayItems({this.list});

  @override
  _DisplayItemsState createState() => _DisplayItemsState();
}

class _DisplayItemsState extends State<DisplayItems> {

  void itemRating(double rating, String name, String logo, String itemId){
    setState(() {
      var info = new Map();
      info['name'] = name;
      info['givenRating'] = rating;
      info['logo'] = logo;
      info['itemId'] = itemId;
      widget.list.add(info);
    });
  }

  @override
  Widget build(BuildContext context) {

    final myItems = Provider.of<List<Item>>(context);
    // myItems.forEach((docs) => print(docs));
    if (myItems == null){
      return LoadingScreen();
    }else{     
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myItems.length,
        itemBuilder: (context, index){
          return Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 0.0, left: 20.0),
                        child: CircleAvatar(
                          radius: 60, 
                          backgroundImage: NetworkImage('${myItems[index].logo}'), 
                          backgroundColor: Colors.transparent, 
                        )
                        
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10,right: 0.0, left: 20.0),
                          child: Text('${myItems[index].name}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)))
                      
                    ],
                  ),
                ),

                 Container(
                  child: Column(
                    children: <Widget>[
                       Container(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 50.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) {itemRating(rating, myItems[index].name, myItems[index].logo, myItems[index].itemId);},
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(top: 10,right: 0.0, left: 40.0),
                  child: Text('myRating/5.0',
                      style:
                          TextStyle(color: Colors.black, fontSize: 18)))
              
                    ],
                  ),
                ),
               
              ],
            );

        });
    }
  }
}