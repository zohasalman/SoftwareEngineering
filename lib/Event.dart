// import 'dart:html';

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Event{ 
//   final String EventId; //unique identifier
  
//   Event({this.EventId});
// }

class Event{
  final String coverimage;
  final String eventID;
  // final LatLng location;
  //final Timestamp enddate;
  final String logo;
  final String invitecode;
  final GeoPoint location1;
  final String name;
  //final Timestamp startdate;
  final String uid;


  Event({this.uid, this.eventID, this.invitecode, this.location1,  this.name,this.logo,this.coverimage});//this.startdate, this.enddate, this.name,this.logo,this.coverimage});

  // EventData.fromData(Map<String, dynamic> data)
  //   : uid = data['uid'],
  //     EventId = data['EventId'],
  //     InviteCode = data['InviteCode'],
  //     Location = data['Location'],
  //     StartDate = data['StartDate'],
  //     EndDate = data['EndDate'],
  //     Name = data['Name'];

  Map<String, dynamic> toJSON(){
    return{
      'uid' : uid, 
      'eventID' : eventID,
      'invitecode' : invitecode,
      'location1' : location1,
      //'StartDate' : StartDate,
      //'EndDate' : EndDate,
      'name' : name,
      'logo' : logo,
      'coverimage' : coverimage,
      //'radius' : radius,
    };
  }
}