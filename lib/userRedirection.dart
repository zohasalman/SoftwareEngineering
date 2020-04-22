import 'package:flutter/material.dart';
import 'package:rateit/hostit.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'hostit.dart';
import 'login.dart';
import 'login.dart';
import 'rateit.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRedirection extends StatefulWidget {

  UserRedirection({this.uid});
  final String uid;

  @override
  _UserRedirectionState createState() => _UserRedirectionState();
}

class _UserRedirectionState extends State<UserRedirection> {

  @override
  //trying using stream
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: FirestoreService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          if (userData.userRole == 'user'){
            return InviteScreen();
          }else if(userData.userRole == 'management'){
            return AddEvent();
          }else{
            return ForgotScreen();
          }
        }
      },
    );
  }
}

// query 
Future<String> getUserRole(String uid) async {
    try{
      String userRole = '';
      await Firestore.instance.document(uid).get().then((value) => userRole = value.data['userRole']);
      return userRole;
    }catch(e){
      return e.toString();
    }
  }