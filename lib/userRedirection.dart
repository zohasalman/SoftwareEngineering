import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rateit/hostit.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'hostit.dart';
import 'hostit_first.dart';
import 'login.dart';
import 'rateit.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Redirection extends StatefulWidget{

  Redirection({this.uid});
  final String uid;

  @override
  RedirectionFunc createState() => RedirectionFunc();
}

class RedirectionFunc extends State<Redirection> {

  @override
  Widget build(BuildContext context) {
    User usr = Provider.of<User>(context);
    String user = usr.uid;
    return StreamProvider<String>.value(
      value: FirestoreService(uid: user).users,
      child: Redirector(uid: user),
    );
  }
}

class Redirector extends StatefulWidget {

  Redirector({this.uid});
  final String uid;

  @override
  RedirectorState createState() => RedirectorState();
}

class RedirectorState extends State<Redirector> {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<String>(context);
    if (usr == 'user'){
      return InviteScreen(uid: '${widget.uid}');
    }
    else if(usr == 'management'){ 
      return HostitHomescreen();//AddVendor(numVen:1,eid:'da');//
    }
    else if(usr == 'Error'){  //Failure to fetch Data, Firebase Error. 
    //TO DO Can be due to internet connection or wrong input, Display a Error Screen with firebase error stated in 
      return ErrorSignIn();
    }
    else if(usr == null){     //Data not Fetched yet or was null
      return LoadingScreen();//Text("Error: Cannot connect to Database");
    }
    else{                     //Test Needed to confirm desired function
      return ForgotScreen();
    }
  }
 }


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.red,
          size: 75.0,
        ) 
      ),
    );
  }
}

class ErrorSignIn extends StatefulWidget {
  @override
  ErrorSignInState createState() => ErrorSignInState();
}

class ErrorSignInState extends State<ErrorSignIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        endDrawer:  SideBar(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppBar(
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.0, left: 10),
                        child: Text('Error',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                       
                      ), 
                    onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);
                    }
                  ),
                  flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [ 
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]
                    ),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                    ),
                  )
                ),
                )
              ],
            ),
            // clipper: ClipShape(),
          )
        ),
        body: Container(
          width: MediaQuery.of(context).copyWith().size.width,
          child: Padding(
            padding: EdgeInsets.all(10.0), 
            child: Center(
              child: Text(
                "Error: Sign In Failed.\nPlease enter the your correct username and password or Make sure you are connected to the internet",
                style: TextStyle(color: Colors.black, fontSize: 28 ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      )
    );
  }
 }

