import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/userRedirection.dart';
import 'item.dart';
import 'package:rating_bar/rating_bar.dart' ;

class RatedItemList extends StatefulWidget {
  @override
  _RatedItemListState createState() => _RatedItemListState();
}

class _RatedItemListState extends State<RatedItemList> {
  @override
  Widget build(BuildContext context) {
    final myRatings = Provider.of<List<RatedItem>>(context);
    if (myRatings == null){
      return LoadingScreen();
    }else{     
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myRatings.length,
        itemBuilder: (context, index){
          return Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 0.0, left: 20.0),
                        child: CircleAvatar(
                          radius: 50, 
                          backgroundImage: NetworkImage('${myRatings[index].itemLogo}'), 
                          backgroundColor: Colors.transparent, 
                        )
                        
                      ),
                      Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(

                          minWidth: 100.0,
                          maxWidth: 100.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: Text( '${myRatings[index].itemName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                      
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
                        RatingBar.readOnly(
                          initialRating: double.parse('${myRatings[index].rating}'),
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
                  child: Text('${myRatings[index].rating}/5.0',
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