import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  final String coverimage;
  final String eventID;
  final String logo;
  final String invitecode;
  final GeoPoint location1;
  final String name;
  final String uid;


  Event({this.uid, this.eventID, this.invitecode, this.location1,  this.name,this.logo,this.coverimage});

  Map<String, dynamic> toJSON(){
    return{
      'uid' : uid, 
      'eventID' : eventID,
      'invitecode' : invitecode,
      'location1' : location1,
      'name' : name,
      'logo' : logo,
      'coverimage' : coverimage,
    };
  }
}