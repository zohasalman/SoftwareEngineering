import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserData{

  SharedPreferences prefs;    

  final CollectionReference _updateCollectionReference = Firestore.instance.collection('users');

  void update(String uid, String firstName, String lastName, String email, String password, String gender, String profilePicture, DateTime dateOfBirth) async {

    prefs = await SharedPreferences.getInstance();
    //If the value is set up for the corresponding functions then set the values for all the corresponding fields 
    if (firstName.isNotEmpty){
      _updateFirstName(uid, firstName);
      prefs.setString('firstName', firstName);
    }
    if (lastName.isNotEmpty){
      _updateLastName(uid, lastName);
      prefs.setString('lastName', lastName);
    }
    if (email.isNotEmpty){
      _updateEmail(uid, email);
      prefs.setString('email', email);
    }
    if (password.isNotEmpty){
      _updatePassword(password);
      if (prefs.getBool('rememberMe') == true){
        prefs.setString('password', password);
      }
    }
    if (gender.isNotEmpty){
      _updateGender(uid, gender);
      prefs.setString('gender', gender);
    }
    if (profilePicture.isNotEmpty){
      _updateProfilePicture(uid, profilePicture);
      prefs.setString('profilePicture', profilePicture);
    }
  }


  //Updating values for profile 

  void _updateFirstName(String uid, String name){
    _updateCollectionReference.document(uid).updateData({'firstName': name});
    print("Succesfull updated firstName");
  }

  void _updateLastName(String uid, String name){
    _updateCollectionReference.document(uid).updateData({'lastName': name});
    print("Succesfull updated lastName");
  }

  void _updateEmail(String uid, String email){
    _updateCollectionReference.document(uid).updateData({'email': email});
    print("Succesfull updated email");
  }

  void _updatePassword(String password) async{
   //Create an instance of the current user. 
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
    });
  }

  void _updateGender(String uid, String gender){
    _updateCollectionReference.document(uid).updateData({'gender': gender});
    print("Succesfull updated gender");
  }

  void _updateProfilePicture(String uid, String profilePicture){
    _updateCollectionReference.document(uid).updateData({'profilePicture' : profilePicture});
    print('Profile Picture updated.');
  }
}