import 'package:flutter/material.dart';

void main2() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HostIt'),
        ),
        body: Center(
          child: Text('Remove this screen'),
        ),
      ),
    );
  }
}