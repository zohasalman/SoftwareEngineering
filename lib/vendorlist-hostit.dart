import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'userRedirection.dart';
import 'hostit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorsListHostit extends StatefulWidget {
  final String eventName;
  VendorsListHostit({this.eventName});
  @override
  _VendorsListStateHostIt createState() => _VendorsListStateHostIt(eventName: eventName);
}

class _VendorsListStateHostIt extends State<VendorsListHostit> {
  String eventName;
  _VendorsListStateHostIt({this.eventName});
  String err;
  @override
  Widget build(BuildContext context) {

    final vendors = Provider.of<List<Vendor>>(context);
    if (vendors == null){
      return LoadingScreen();
    }
    else{
      return Column(children: <Widget>[
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              return Card(
                child:ListTile(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EditVen(vendorData: vendors[index], eventName: eventName,)),);
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
                                await Firestore.instance.collection('Vendor').document(vendors[index].vendorId).delete().then((_) async {
                                    await Firestore.instance.collection('ratedVendor').where('vendorId', isEqualTo: vendors[index].vendorId).getDocuments().then((val) async{
                                      val.documents.forEach((doc) async {
                                        await Firestore.instance.collection('ratedVendor').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                      });
                                    }).catchError((e){err=e.toString();});
                                    await Firestore.instance.collection('item').where('vendorId', isEqualTo: vendors[index].vendorId).getDocuments().then((val) async{
                                      val.documents.forEach((doc) async {
                                        await Firestore.instance.collection('item').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                      });
                                    }).catchError((e){err=e.toString();});
                                    await Firestore.instance.collection('ratedItems').where('vendorId', isEqualTo: vendors[index].vendorId).getDocuments().then((val) async{
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
                  title: Text(vendors[index].name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${vendors[index].logo}'),
                  ),
                )
              );
            }
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