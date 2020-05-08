import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/userRedirection.dart';
import 'item.dart';
import 'package:rating_bar/rating_bar.dart' ;
 
class EditMyRatingsItems extends StatefulWidget {

  final List<Map> list;
  EditMyRatingsItems({this.list});

  @override
  _EditMyRatingsItemsState createState() => _EditMyRatingsItemsState();
}

class _EditMyRatingsItemsState extends State<EditMyRatingsItems> {

  void itemRating(double rating, String itemId){
    bool update = false;
    widget.list.forEach((f){
      if (itemId == f['itemId']){
        f['givenRating'] = rating;
        update = true;
      }
    });
    if(update == false){
        setState(() {
          var info = new Map();
          info['givenRating'] = rating;
          info['itemId'] = itemId;
          widget.list.add(info);
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

  final myItems = Provider.of<List<RatedItem>>(context);

   if (myItems == null){
      return LoadingScreen();
    }else{     
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myItems.length,
        itemBuilder: (context, index){
          return SafeArea(
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 0.0, left: 20.0),
                        child: CircleAvatar(
                          radius: 60, 
                          backgroundImage: NetworkImage('${myItems[index].itemLogo}'), 
                          backgroundColor: Colors.transparent, 
                        )
                        
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10,right: 0.0, left: 10.0),
                          child: Text('${myItems[index].itemName}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)))
                      
                    ],
                  ),
                ),

                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 35.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          initialRating: double.parse('${myItems[index].rating}'),
                          onRatingChanged: (rating){itemRating(rating, myItems[index].itemId);},
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 30,
                        ),
                        
                        // Text(
                        //   '$myrating/5',
                        //   style: TextStyle(color: Colors.black, fontSize: 15),
                        // )
                      ],
                    ),
                  ),
                )),
              ],
            ));
        }
      );
    }
  }
}
          
          
          
          
         