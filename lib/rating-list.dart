import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my-rating.dart';
import 'userRedirection.dart';
import 'rateit.dart';

class RatingList extends StatefulWidget {
  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  @override
  Widget build(BuildContext context) {

    final myRatings = Provider.of<List<MyRating>>(context);
    // myRatings.forEach((f) => print(f));
    if (myRatings == null){
      return LoadingScreen();
    }else{          
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myRatings.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new EditRatings(
                      value: '${myRatings[index].vendorName}',
                      image: '${myRatings[index].vendorLogo}',
                      rating: myRatings[index].rating.toString(),
                      item_Id:'${myRatings[index].itemId}' ,
                      ),
                );
                Navigator.of(context).push(route);
              },
              title: Text('${myRatings[index].vendorName}'),
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage('${myRatings[index].vendorLogo}'),
              ),
              trailing: Text('${myRatings[index].rating}'),
            ),
          );
        });
    }
  }
}