//Copied code, delete during integration
import 'package:flutter/material.dart';
import 'package:rateit/wrapper.dart';
import 'package:rateit/user.dart';
import 'package:rateit/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
      theme:  ThemeData(
          primaryColor: Colors.pink,
        ),
        home: Wrapper(), // decides to sbow login screen or homepage
      ),
    );
  }
}
