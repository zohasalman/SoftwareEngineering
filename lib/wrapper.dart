import 'package:flutter/material.dart';
import 'package:rateit/authenticate.dart';
import 'package:rateit/hostit.dart';
import 'package:rateit/user.dart';
import 'package:provider/provider.dart';
import 'package:rateit/rateit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {

  final databaseReference = Firestore.instance;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //accessing user data to know changes such as login/logout
    print(user);
    if (user == null){
      return Authenticate();
    }else{
      dynamic result = query(user.toString());
      print(result);
      return InviteScreen();
      // dynamic userInfo = result.getData();
      // print(result);
      // if (userRole == 'user'){
      //   return InviteScreen();
      // }else{
      //   return AddEvent();
      // }
    }
  }
}

  dynamic query(String uid) async{
    dynamic sol;
    await Firestore.instance.collection('users').document(uid).get().then((data) => sol = data);
    return sol.data;
  }
