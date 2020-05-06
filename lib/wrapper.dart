import 'package:flutter/material.dart';
import 'package:rateit/login.dart';
import 'package:rateit/user.dart';
import 'package:provider/provider.dart';
import 'package:rateit/userRedirection.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //accessing user data to know changes such as login/logout
    print(user);
    if (user == null){
      return LoginScreen();
    }else{
      String uid = user.uid.toString();
      return Redirection(uid: uid);
    }
  }
}