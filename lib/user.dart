class User{ 
  final String uid; //unique identifier
  
  User({this.uid});
}

class UserData{
  final String uid;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime dateOfBirth;
  final String email;
  final String userRole;

  UserData({this.uid, this.firstName, this.lastName, this.gender, this.dateOfBirth, this.email, this.userRole});

  UserData.fromData(Map<String, dynamic> data)
    : uid = data['uid'],  
      firstName = data['firstName'], 
      lastName = data['lastName'], 
      gender = data['gender'], 
      dateOfBirth = data['dateOfBirth'], 
      email = data['email'], 
      userRole = data['userRole'];

  Map<String, dynamic> toJSON(){
    return{
      'uid' : uid, 
      'firstName' : firstName,
      'lastName' : lastName,
      'gender' : gender,
      'dateOfBirth' : dateOfBirth,
      'email' : email, 
      'userRole' : userRole
    };
  }
}