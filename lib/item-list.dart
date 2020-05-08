import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'hostit.dart';
import 'userRedirection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index){
          return 
          SafeArea(
          child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 0.0, left: 20.0),
                        child: CircleAvatar(
                          radius: 50.0, 
                          backgroundImage: NetworkImage('${items[index].logo}'), 
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
                        child: Text( '${items[index].name}',
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
                          initialRating: double.parse('${items[index].aggregateRating}'),
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
                          child: Text('${items[index].aggregateRating}/5.0',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)))
                      
                    ],
                  ),
                ),
               
              ],
            ));
      });
    }
  }
}


class ListItemHostIt extends StatefulWidget {                                                                 //Items List builder for Host It
  ListItemHostIt({this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  @override
  _ListItemStateHostIt createState() => _ListItemStateHostIt(eventID: eventID,eventName: eventName);
}

class _ListItemStateHostIt extends State<ListItemHostIt> {
  _ListItemStateHostIt({this.eventName, this.eventID});
  String eventName;
  String eventID;
  String err;

  @override
  Widget build(BuildContext context) {

    final items = Provider.of<List<Item>>(context);
    if (items == null){
      return LoadingScreen();
    }
    else{
      return Column(children:[
        //child: 
        Container(child:ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index){
            return Card(
              child:ListTile(
                onTap: () {                                                                                               //single tapping list tile will open the option to edit data
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> EditMenu(itemData: items[index],)),);
                },
                onLongPress: () async {                                                                                   //long pressing list tile will open the option to delete data
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Are you sure you want to delete ${items[index].name}?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () async {                                                                                   //pressing delete will the corresponding data in firebase database
                              print(items[index].name);
                              await Firestore.instance.collection('item').document(items[index].itemId).delete().then((_)async{
                                await Firestore.instance.collection('ratedItems').where('itemId', isEqualTo: items[index].itemId).getDocuments().then((val) async{
                                  val.documents.forEach((doc) async {
                                    await Firestore.instance.collection('ratedItems').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                  });
                                }).catchError((e){err=e.toString();});
                              }).catchError((e){err=e.toString();});
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
                title: Text(items[index].name.trim()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('${items[index].logo}'),
                ),
              )
            );
          },),
        ),
        Padding(padding: EdgeInsets.all(30),),
        Center(                                               //Submit button to save changes in vendor details and go back to event menu
          child: Container(
            width:60,
            height:60,
            child: Center( child: Ink(
              width:60,
              height:60,
              decoration:  ShapeDecoration(
                shape: CircleBorder(),
                color: null,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                ),
                shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
              ),
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(Icons.arrow_forward,
                  size: 45,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewVendor(eventID:eventID,eventName:eventName)),);
                },
              ),
            ),),
          ),
        ),
        SafeArea(
          child: err== null ? Container() : Container(
            padding:EdgeInsets.only( top: 5), 
            child: Column(
              children: <Widget>[
                
                Container(
                  alignment: Alignment(-0.8,-0.9),
                    child: Text(err,
                    style: TextStyle(color: Colors.red)
                    ),
                ),
              ],
            )                        
          ),
        ),
      ],);
    }
  }
}