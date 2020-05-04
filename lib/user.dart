class User{ 
  final String uid; //unique identifier
  
  User({this.uid});
}

class UserData{
  String uid;
  String firstName;
  String lastName;
  String gender;
  DateTime dateOfBirth;
  String email;
  String userRole;
  String profilePicture;

  UserData({this.uid, this.firstName, this.lastName, this.gender, this.dateOfBirth, this.email, this.userRole, this. profilePicture});

  UserData.fromData(Map<String, dynamic> data)
    : uid = data['uid'],  
      firstName = data['firstName'], 
      lastName = data['lastName'], 
      gender = data['gender'], 
      dateOfBirth = data['dateOfBirth'], 
      email = data['email'], 
      userRole = data['userRole'],
      profilePicture = data['profilePicture'];

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

  void update(String _firstName, String _lastName, String _email, String _gender, String _profilePicture){
    if(_firstName.isNotEmpty){
      this.firstName = _firstName;
    }
    if (_lastName.isNotEmpty){
      this.lastName = _lastName;
    }
    if (_email.isNotEmpty){
      this.email = _email;
    }
    if(_gender.isNotEmpty){
      this.gender = _gender;
    }
    if(_profilePicture.isNotEmpty){
      this.profilePicture = _profilePicture;
    }

  }
}