import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateit/user.dart';

class FirestoreService{

  final CollectionReference _usersCollectionReference = Firestore.instance.collection('users');

  Future registerUser(UserData user) async{
    try {
      await _usersCollectionReference.document(user.uid).setData(user.toJSON());
    } catch (e) {
      return e.message;
    }
  }

}