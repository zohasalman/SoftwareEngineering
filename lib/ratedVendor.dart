import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'rateit.dart';
//import 'hostit.dart';

class RatedVendorList extends StatefulWidget {
  @override
  _RatedVendorListState createState() => _RatedVendorListState();
}

class _RatedVendorListState extends State<RatedVendorList> {
  @override
  Widget build(BuildContext context) {

    final myRatings = Provider.of<List<RatedVendor>>(context);
    // myRatings.forEach((f) => print(f));
    if (myRatings == null){
      return Container(
        child: Text('No User Ratings found.'),
        ); // print no rating found
    }else{          
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myRatings.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                print('reviewId: ${myRatings[index].reviewId}');
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new EditRatings(
                      name: '${myRatings[index].vendorName}',
                      image: '${myRatings[index].vendorLogo}',
                      rating: myRatings[index].rating.toString(),
                      vendorId:'${myRatings[index].vendorId}',
                      reviewId:'${myRatings[index].reviewId}' ,
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

