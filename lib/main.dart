//Copied code, delete during integration
import 'package:flutter/material.dart';
import 'package:rateit/wrapper.dart';
import 'package:rateit/user.dart';
import 'package:rateit/auth.dart';
import 'package:rateit/hostit.dart';
import 'package:rateit/rateit.dart';
import 'package:rateit/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       value: AuthService().user,
//       child: MaterialApp(
//         home: Wrapper(), // decides to sbow login screen or homepage
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Test Screen';

    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly, 
          children: <Widget>[
            Button1(),
            Button2(),
            Button3(),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        main2();
      },
      // The custom button
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text('My Button'),
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
       main1();
      },
      // The custom button
      child: Container(
        width: 280.0,
        height: 120.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [ 
              Color(0xFFAC0D57),
              Color(0xFFFC4A1F),
            ]
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(12.0),
        child:Center(
          child: 
            Text('Login',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 22
              ) 
            ),
        ),
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        main2();
      },
      // The custom button
      child: Container(
        width: 280.0,
        height: 120.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [ 
              Color(0xFFAC0D57),
              Color(0xFFFC4A1F),
            ]
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(12.0),
        child:Center(
          child: 
            Text('Host It!',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 22
              ) 
            ),
        ),
      ),
    );
  }
}


class Button3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        main3();
      },
      // The custom button
      child: Container(
        width: 280.0,
        height: 120.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [ 
              Color(0xFFAC0D57),
              Color(0xFFFC4A1F),
            ]
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(12.0),
        child:Center(
          child: 
            Text('Rate It!',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 22
              ) 
            ),
        ),
      ),
    );
  }
}