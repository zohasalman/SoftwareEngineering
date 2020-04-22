import 'package:flutter/material.dart';
import 'package:rateit/login.dart';
import 'package:rateit/rateit.dart';
import 'package:rateit/hostit.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return LoginScreen(toggleView: toggleView);
    }else{
      return SignScreen(toggleView: toggleView);
    }
  }
}