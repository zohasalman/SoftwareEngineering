import 'package:flutter/material.dart';

void main3() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('RateIt'),
        ),
        body: Center(
          child: Text('Remove this screen'),
        ),
      ),
    );
  }
}