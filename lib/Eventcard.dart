import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vendor.dart';
import 'userRedirection.dart';
import 'hostit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class EventsListHostit extends StatefulWidget {
  
  final UserData myUserInfo;
  final String eventName;
  
  EventsListHostit({this.eventName, this.myUserInfo});
  @override
  _EventsListStateHostIt createState() => _EventsListStateHostIt();
}

class _EventsListStateHostIt extends State<EventsListHostit> {
  
  @override
  Widget build(BuildContext context) {

    final vendors = Provider.of<List<Vendor>>(context);
    if (vendors == null){
      return LoadingScreen();
    }else{
      return 
      // Stack( children: <Widget>[
      //   Container(
      //     child: Text(
      //       "Long Press to delete vendor",
      //       style: TextStyle(color: Colors.pink[600], fontSize: 17),
      //     ),
      //   ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              return Card(
                child:ListTile(
                  onTap: () {
                    //debugPrint('${vendors[index].name} is pressed!');
                    // var route = new MaterialPageRoute(
                    //   builder: (BuildContext context) => new EditVen(
                    //       //value: '${vendors[index].name}',
                    //       //image: '${vendors[index].logo}', 
                    //       //vendorId: '${vendors[index].vendorId}'
                    //   ),
                    // );
                    //Navigator.of(context).push(route);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EditVen(myUser: widget.myUserInfo,  vendorData: vendors[index], eventName: widget.eventName,)),);
                  },
                  onLongPress: () async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Confirm"),

                          content: Text("Are you sure you want to delete this vendor?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                await Firestore.instance.collection('Vendor').document(vendors[index].vendorId).delete();
                                Navigator.of(context).pop(false);
                              },
                              child: Text("Delete"),
                            ),
                            FlatButton(
                              onPressed: ()=>Navigator.of(context).pop(false),
                              child: Text("Cancel"),
                            )
                          ],
                        ); 
                      },
                    ); 
                  },
                  title: Text(vendors[index].name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${vendors[index].logo}'),
                  ),
                )
              );
            }
          ),
        );
    }
  }
}



// class EventCard {
//   final String flowerName;
//   final String description;
//   final String imageURL;
//   //Constructor
//   const EventCard({
//     this.flowerName,
//     this.description,
//     this.imageURL
//   });
// }