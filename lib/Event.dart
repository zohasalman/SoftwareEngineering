import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event{ 
  final String EventId; //unique identifier
  
  Event({this.EventId});
}

class EventData{
  final String EventId;
  final String InviteCode;
  final LatLng Location;
  final DateTime StartDate;
  final DateTime EndDate;
  final String Name;
  final String uid;


  EventData({this.uid, this.EventId, this.InviteCode, this.Location, this.StartDate, this.EndDate, this.Name});

  EventData.fromData(Map<String, dynamic> data)
    : uid = data['uid'],
      EventId = data['EventId'],
      InviteCode = data['InviteCode'],
      Location = data['Location'],
      StartDate = data['StartDate'],
      EndDate = data['EndDate'],
      Name = data['Name'];

  Map<String, dynamic> toJSON(){
    return{
      'uid' : uid, 
      'EventId' : EventId,
      'InviteCode' : InviteCode,
      'Location' : Location,
      'StartDate' : StartDate,
      'EndDate' : EndDate,
      'Name' : Name,
    };
  }
}