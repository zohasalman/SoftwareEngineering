class Event{ 
  final String uid; //unique identifier
  
  Event({this.uid});
}

class EventData{
  final String EventId;
  final String InviteCode;
  final String Location;
  final String gender;
  final DateTime dateOfBirth;
  final String email;
  final String EventRole;

  EventData({this.uid, this.firstName, this.lastName, this.gender, this.dateOfBirth, this.email, this.EventRole});

  EventData.fromData(Map<String, dynamic> data)
    : uid = data['uid'],
      firstName = data['firstName'],
      lastName = data['lastName'],
      gender = data['gender'],
      dateOfBirth = data['dateOfBirth'], 
      email = data['email'],
      EventRole = data['EventRole'];

  Map<String, dynamic> toJSON(){
    return{
      'uid' : uid, 
      'firstName' : firstName,
      'lastName' : lastName,
      'gender' : gender,
      'dateOfBirth' : dateOfBirth,
      'email' : email, 
      'EventRole' : EventRole
    };
  }
}