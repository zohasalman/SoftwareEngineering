import 'package:flutter/material.dart';
import 'package:rateit/hostit.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'hostit.dart';
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



class LoadingScreen extends StatefulWidget{

  LoadingScreen({this.uid});
  final String uid;

  @override
  LoadingScreenFunc createState() => LoadingScreenFunc();
}

class LoadingScreenFunc extends State<LoadingScreen> {

  // startTime() async {
  //     var _duration = new Duration(seconds: 5);
  //     return new Timer(_duration, navigationPage);
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   startTime();
  // }

  // @override 
  // void routing(){
  //   User user = Provider.of<User>(context);
  //   StreamBuilder<UserData>(
  //     stream: FirestoreService(uid: user.uid).userData,
  //     builder: (context, snapshot){
  //       if(snapshot.hasData){
  //         UserData userData = snapshot.data;
  //         if (userData.userRole == 'user'){
  //           return InviteScreen();
  //         }else if(userData.userRole == 'management'){
  //           return AddEvent();
  //         }else{
  //           return ForgotScreen();
  //         }
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                      child: Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 28 ))
                      ),
                  )
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
          clipper: ClipShape(),
        )
      ),

      body: Column(
        child: Center(
          child: Text('Signing In',
            style: TextStyle(
              color: Colors.white, fontSize: 22 
            ),
          )
        )
      )
    );
  }
}