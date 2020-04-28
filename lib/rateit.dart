import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/login.dart';
import 'firestore.dart';
import 'dart:math' as math;
import 'VendorList.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as prefix;
import 'localData.dart';
import 'user.dart';
import 'dart:convert';
import 'vendor-list.dart';
import 'vendor.dart';
import 'package:intl/intl.dart';
import 'package:rating_bar/rating_bar.dart';
import 'item-list.dart';
import 'item.dart';
import 'edit-profile.dart';
import 'my-rating.dart';
import 'rating-list.dart';

import 'package:barcode_scan/barcode_scan.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';
// import 'package:camera/camera.dart';
// import 'package:qrcode_reader/qrcode_reader.dart';
DateTime _dateTime;
String user_id;
void main3() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: <String, WidgetBuilder>{
          "/rateitfirst": (BuildContext context) => new _RateItFirstScreen(),
          "/rateitsecond": (BuildContext context) => new ViewVendor(),
          '/EditProfileScreen': (BuildContext context) => new EditProfile(),
          '/Viewratings': (BuildContext context) => new ViewMyRating(),
          '/editrating1': (BuildContext context) => new EditRating1(),
          '/doratings': (BuildContext context) => new DoRatings(),
          '/changeratings': (BuildContext context) => new ChangeRatings(),
        }));

class SideBar2 extends StatefulWidget {
  @override
  SideBarProperties2 createState() => new SideBarProperties2();
}

class SideBarProperties2 extends State<SideBar2> {
  void NormalSignOut() async {
    User usr = Provider.of<User>(context, listen: false);
    String user = usr.uid;
    user_id = usr.uid;
    await FirestoreService(uid: user).normalSignOutPromise();
    LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
            ),
            Text('Uzair Mustafa',
                style: TextStyle(fontSize: 30, color: Colors.black)),
            Text('uzairmustafa@rateit.com',
                style: TextStyle(fontSize: 22, color: Colors.black)),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container(
                child: GestureDetector(
              onTap: () {
                //Change on Integration
                //Navigator.of(context).pushNamed("/EditProfileScreen");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              child: Container(
                width: 230.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Container(
                child: GestureDetector(
              onTap: () {
                //Change on Integration
                //Navigator.of(context).pushNamed("/Viewratings");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewMyRating()),
                );
              },
              child: Container(
                width: 230.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('View my Ratings',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Container(
                child: GestureDetector(
              onTap: () async {
                await FirestoreService().normalSignOutPromise();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              // },
              child: Container(
                width: 230.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Sign Out',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            )),
          ]),
    );
  }
}

class InviteScreen extends StatefulWidget {

  InviteScreen({this.uid});
  final String uid;

  @override
  State<StatefulWidget> createState() {
    return _InviteScreen();
  }
}

class _InviteScreen extends State<InviteScreen> {
  String inviteCode = '';
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirestoreService();

  void submitInviteCode() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String eventName = '';
      String eventID = '';
      _firestore.verifyInviteCode(inviteCode).then((QuerySnapshot docs) {
        if (docs.documents.isNotEmpty) {
          eventName = docs.documents[0].data['name'];
          eventID = docs.documents[0].data['eventID'];
          user_id = '${widget.uid}';
          print(eventName);
          print(eventID);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => _RateItFirstScreen(
                      eventName: eventName, eventID: eventID)));
        } else {
          errorMessage = 'No such event invite code exists.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: Transform.scale(
                scale: 1.5,
                child: Transform.rotate(
                  angle: -math.pi / 18,
                  child: Transform.translate(
                    offset: Offset(0, -60),
                    child: Container(
                      height: 175,
                      width: 1000,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color(0xFFAC0D57),
                              Color(0xFFFC4A1F),
                            ]),
                        image: DecorationImage(
                            image: AssetImage("asset/image/Chat.png")),
                      ),
                      child: Transform.translate(
                        offset: Offset(10, 70),
                        child: Transform.rotate(
                            angle: math.pi / 18,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Container(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 50,
                                              top: 78,
                                              left: 80,
                                              right: 80),
                                          child: Text("Invite Code",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)))),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Transform.translate(
                  offset: Offset(0.0, 70.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: new Theme(
                          data: new ThemeData(
                            primaryColor: Colors.pink,
                          ),
                          child: TextFormField(
                              cursorColor: Colors.pink,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter invite code';
                                }
                                if (value.length > 6 || value.length < 6) {
                                  return 'Invalid invite code';
                                }
                              },
                              onSaved: (value) => inviteCode = value.trim(),
                              decoration: InputDecoration(
                                  labelText: 'Enter invite code',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink),
                                      borderRadius:
                                          BorderRadius.circular(80.0))))))),
            ),
            Container(
              child: Transform.translate(
                offset: Offset(0.0, 100.0),
                child: RaisedButton(
                  onPressed: () {
                    submitInviteCode();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFAC0D57), Color(0xFFFC4A1F)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RateItFirstScreen extends StatefulWidget {
  _RateItFirstScreen({this.eventName, this.eventID});
  final String eventName;
  final String eventID;

  @override
  State<StatefulWidget> createState() {
    return RateItFirstScreen();
  }
}

class RateItFirstScreen extends State<_RateItFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            decoration: BoxDecoration(),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Transform.scale(
                    scale: 1.3,
                    child: Transform.translate(
                      offset: Offset(0, -50),
                      child: Container(
                        height: 2000,
                        width: 2500,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("asset/image/rateit.png")),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Transform.rotate(
                    angle: math.pi,
                    child: Transform.scale(
                      scale: 1.3,
                      child: Transform.translate(
                        offset: Offset(0, -150),
                        child: Container(
                          height: 2000,
                          width: 2300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("asset/image/rateit.png")),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Transform.translate(
                    offset: Offset(0, -335),
                    child: Container(
                      padding: EdgeInsets.only(top: 0, left: 20),
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Welcome to",
                            style:
                                TextStyle(color: Colors.black, fontSize: 35)),
                      ])),
                    ),
                  ),
                ),
                Container(
                  child: Transform.translate(
                    offset: Offset(0, -325),
                    child: Container(
                      padding: EdgeInsets.only(top: 0, left: 20),
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "${widget.eventName}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 35)),
                      ])),
                    ),
                  ),
                ),
                Container(
                  child: Transform.translate(
                    offset: Offset(0.0, -260.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewVendor(
                                    eventName: '${widget.eventName}',
                                    eventID: '${widget.eventID}')));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => _RateItSecondScreen(name: '${widget.name}')));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFAC0D57), Color(0xFFFC4A1F)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

// idk why this screen.
// class _RateItSecondScreen extends StatefulWidget {

//   _RateItSecondScreen({this.eventName});
//   final String eventName;

//   @override
//   State<StatefulWidget> createState() {
//     return RateItSecondScreen();
//   }
// }

// class RateItSecondScreen extends State<_RateItSecondScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: Container(
//             decoration: BoxDecoration(),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   child: Transform.scale(
//                     scale: 1.5,
//                     child: Transform.rotate(
//                       angle: -math.pi / 18,
//                       child: Transform.translate(
//                         offset: Offset(0, -60),
//                         child: Container(
//                           height: 175,
//                           width: 2000,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 begin: Alignment.topRight,
//                                 end: Alignment.topLeft,
//                                 colors: [
//                                   Color(0xFFAC0D57),
//                                   Color(0xFFFC4A1F),
//                                 ]),
//                             image: DecorationImage(
//                                 image: AssetImage("asset/image/Chat.png")),
//                           ),
//                           child: Transform.translate(
//                             offset: Offset(0, 60),
//                             child: Transform.rotate(
//                                 angle: math.pi / 18,
//                                 child: Stack(
//                                   children: <Widget>[
//                                     Positioned(
//                                       child: Container(
//                                           child: Padding(
//                                               padding: EdgeInsets.only(
//                                                   bottom: 50,
//                                                   top: 78,
//                                                   left: 80,
//                                                   right: 80),
//                                               child: Text('${widget.eventName}',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 22)))),
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Transform.translate(
//                     offset: Offset(180, -140),
//                     child: Container(
//                       height: 50,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("asset/image/menu.png")),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Transform.translate(
//                     offset: Offset(180, -140),
//                     child: Container(
//                       height: 50,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("asset/image/search.png")),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Transform.translate(
//                     offset: Offset(140, 250),
//                     child: Container(
//                       height: 250,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("asset/image/camera.png")),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )));
//   }
// }

class Clipshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var clipline = new Path();
    clipline.lineTo(0, size.height - 0);
    clipline.lineTo(size.width, size.height - 100);
    clipline.lineTo(size.width, 0);
    return clipline;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  String _name, _email, _password, _gender;
  DateTime _dateOfBirth;

  final _formKey = GlobalKey<FormState>();
  final EditUserData _updateData = EditUserData();

  void submit() {
    _formKey.currentState.save();
    _updateData.update(user_id, _name, _email, _password, _gender, _dateOfBirth);
    // TODO: Send an alert that data updated
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _formKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(370.0),
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
                              padding: EdgeInsets.only(bottom: 300.0, left: 18),
                              child: Text('Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 110.0),
                          child: GestureDetector(
                              onTap: () {
                                print("Upload Photo");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70.0,
                                child: Image.asset('asset/image/circular.png'),
                              ))),
                      Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Uzair Mustafa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ))),
                      Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('uzairmustafa@rateit.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              )))
                    ],
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        endDrawer: SideBar2(),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              Align(
                alignment: Alignment
                    .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                child: Text(
                  "Account Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Image.asset('asset/image/name.png'),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      onSaved: (input) => _name = input.trim(),
                      decoration: InputDecoration(
                        hintText: 'Enter a name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('asset/image/right arrow.png'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Image.asset('asset/image/email.png'),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      onSaved: (input) => _email = input.trim(),
                      decoration: InputDecoration(
                        hintText: 'Enter an email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('asset/image/right arrow.png'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Image.asset('asset/image/password.png'),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      onSaved: (input) => _password = input.trim(),
                      decoration: InputDecoration(
                        hintText: 'Enter a password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('asset/image/right arrow.png'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Image.asset('asset/image/gender.png'),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      onSaved: (input) => _gender = input.trim(),
                      decoration: InputDecoration(
                        hintText: 'Enter a Gender',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('asset/image/right arrow.png'),
                ],
              ),
              SizedBox(height: 10),
              Container(
                  child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text('Date of Birth',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 19)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 20),
                    child: RaisedButton(
                      child: Text(
                          _dateTime == null
                              ? 'DD-MM-YYYY'
                              : DateFormat('dd-MM-yyyy').format(_dateTime),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 19)),
                      onPressed: () {
                        //print('here');
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.pink,
                                  accentColor: Colors.deepOrange,
                                  splashColor: Colors.deepOrange,
                                ),
                                child: child,
                              );
                            }).then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                    ),
                  )
                ],
              )),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Container(
                  child: GestureDetector(
                onTap: () {
                  print('Submit pressed');
                  submit();
                },
                child: Container(
                  width: 120.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text('Submit',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

List<String> genders = ['Male', 'Female', 'Other'];
final genderSelected = TextEditingController();

class ViewVendor extends StatefulWidget {
  ViewVendor({this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  String qr = "";

  @override
  State<StatefulWidget> createState() {
    return _ViewVendor();
  }
}

class _ViewVendor extends State<ViewVendor> {
  String result;
  UserData userInfo;
  String qr = "";

  // Future _scanQR() async{
  //   try {
  //     var qrResult = await BarcodeScanner.scan();
  //     setState(() {
  //       //
  //     });

  //   }on PlatformException catch (ex) {
  //     if (ex.code == BarcodeScanner.cameraAccessDenied)
  //     {
  //       setState(() {
  //         result = 'Camera permission was denied';
  //       });

  //     } else {
  //       setState(() {
  //         result = 'Unknown Error $ex';
  //       });
  //     }
  //   } on FormatException {
  //     setState(() {
  //       result = 'You pressed the back without scanning anything';
  //     });
  //   } catch (ex) {
  //     setState(() {
  //       result = 'Unknown Error $ex';
  //     });
  //   }
  // }
  // List<VendorList> vendors = [
  //   VendorList(
  //       vendorname: 'Cloud Naan', flag: 'cloudnaan.png', vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'KFC', flag: 'kfc.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'McDonalds', flag: 'mcdonalds.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'No Lies Fries',
  //       flag: 'noliesfries.png',
  //       vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'Caffe Parha',
  //       flag: 'caffeparha.png',
  //       vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'DOH', flag: 'doh.png', vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'Carbie', flag: 'carbie.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'The Story', flag: 'thestory.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'Meet the Cheese',
  //       flag: 'meetthecheese.png',
  //       vendorrating: '4.5/5'),
  // ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // start of getting local stored user info
    readContent().then((String value) {
      Map userMap = jsonDecode(value);
      var user = UserData.fromData(userMap);
      userInfo = json.decode(value);
    });
    //print(userInfo);  // some error generated here
    // end of it
  }

  @override
  Widget build(BuildContext context) {
    // final vendorFromDB = Provider.of<List<Vendor>>(context);

    return StreamProvider<List<Vendor>>.value(
      value: FirestoreService().getVendorInfo('${widget.eventID}'),
      child: Scaffold(
        key: scaffoldKey,
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
                              padding: EdgeInsets.only(bottom: 60.0, left: 10),
                              child: Text('${widget.eventName}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        endDrawer: SideBar2(),
        body: VendorsList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[800],
          child: Image.asset("asset/image/Camera_1.png"),
          onPressed: () async {
            //Navigator.of(context).pushNamed('/doratings');
            String scanning = await BarcodeScanner.scan();

            setState() {
              var qr = scanning;
            }
          },
        ),
      ),
    );
  }
}

class ViewMyRating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ViewMyRating();
  }
}

class _ViewMyRating extends State<ViewMyRating> {
  String result;

  // List<VendorList> vendors = [
  //   VendorList(
  //       vendorname: 'Cloud Naan', flag: 'cloudnaan.png', vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'KFC', flag: 'kfc.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'McDonalds', flag: 'mcdonalds.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'No Lies Fries',
  //       flag: 'noliesfries.png',
  //       vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'Caffe Parha',
  //       flag: 'caffeparha.png',
  //       vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'DOH', flag: 'doh.png', vendorrating: '4.5/5'),
  //   VendorList(vendorname: 'Carbie', flag: 'carbie.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'The Story', flag: 'thestory.png', vendorrating: '4.5/5'),
  //   VendorList(
  //       vendorname: 'Meet the Cheese',
  //       flag: 'meetthecheese.png',
  //       vendorrating: '4.5/5'),
  // ];
  String qr = "";

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MyRating>>.value(
      value: FirestoreService().getMyRating(user_id),
      child: Scaffold(
        key: scaffoldKey,
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
                              padding: EdgeInsets.only(bottom: 60.0, left: 10),
                              child: Text('My Ratings',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        body: RatingList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[800],
          child: Image.asset("asset/image/Camera 1.png") ,
          onPressed: () async {
              //Navigator.of(context).pushNamed('/doratings');
              String scanning ;//= await BarcodeScanner.scan(); 
              setState(){
                qr=scanning; 
          }
          },
        ),
      ),
    );
  }
}

class EditRatings extends StatefulWidget {
  String value, image, rating, item_Id;

  EditRatings({this.value, this.image, this.rating, this.item_Id});

  @override
  _EditRatings createState() => new _EditRatings();
}

class _EditRatings extends State<EditRatings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider <List<Item>>.value(
      value: FirestoreService().getMyRatingItem('${widget.item_Id}'),
      child: Scaffold(
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
                              padding: EdgeInsets.only(bottom: 60.0, left: 10),
                              child: Text('${widget.value}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Image.network('${widget.image}'),
                ),
              ),
              RatingBar.readOnly(
                initialRating: double.parse('${widget.rating}'),
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                filledColor: Colors.amber,
                emptyColor: Colors.amber,
                halfFilledColor: Colors.amber,
                size: 40,
              ),
              ListItem(),
              FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new ChangeRatings(
                        value: '${widget.value}', image: '${widget.image}'),
                  );
                  Navigator.of(context).push(route);
                },
              ),
            ]
            )
          )
        ),
      )
    );
  }
}

class EditRating1 extends StatefulWidget {
  String value, image;

  EditRating1({Key key, this.value, this.image}) : super(key: key);
  @override
  _EditRating1State createState() => _EditRating1State();
}

class _EditRating1State extends State<EditRating1> {
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('Edit Rating',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              alignment: Alignment(0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Text('${widget.value}',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    alignment: Alignment(0.00, 0.0),
                    height: 200.0,
                    width: 200.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.asset('${widget.image}'),
                    ),
                  ),
                  new Divider(),
                  Container(
                      child: Text('How would you like to rate this stall?',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 40.0, right: 0.0, left: 15.0),
                      child: Column(
                        children: <Widget>[
                          RatingBar(
                            onRatingChanged: (rating) =>
                                setState(() => rating = rating),
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            halfFilledIcon: Icons.star_half,
                            isHalfAllowed: true,
                            filledColor: Colors.amber,
                            emptyColor: Colors.amber,
                            halfFilledColor: Colors.amber,
                            size: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 150.0, width: 40.0),
                  // Container(
                  //   height: 70,
                  //   width: 250,
                  //   child: RaisedButton(
                  //     shape: new RoundedRectangleBorder(
                  //         borderRadius: new BorderRadius.circular(50.0),
                  //         side: BorderSide(color: Colors.red),
                  //         ),

                  //     onPressed: () {},
                  //     color: Colors.red,
                  //     textColor: Colors.white,
                  //     child: Text("Submit".toUpperCase(),
                  //         style: TextStyle(fontSize: 18)),
                  //   ),
                  // )
                  Container(
                    child: Transform.translate(
                        offset: Offset(0.0, 100.0),
                        child: RaisedButton(
                          onPressed: () {
                            AlertDialog(
                              content: Text(
                                'Success!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22),
                              ),
                            );
                           
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFAC0D57),
                                      Color(0xFFFC4A1F)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ))),
    );
  }
}

class DoRatings extends StatefulWidget {
  String value, image;

  DoRatings({Key key, this.value, this.image}) : super(key: key);

  @override
  _DoRatings createState() => new _DoRatings();
}

class _DoRatings extends State<DoRatings> {
  double myrating;
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('McDonalds',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                child: Image.asset('asset/image/mcdonalds.png'),
              ),
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 20.0),
                  child: Text('Top Rated Items',
                      style: TextStyle(color: Colors.red, fontSize: 22)),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 60.0),
                  child: Text('Reviews',
                      style: TextStyle(color: Colors.red, fontSize: 22)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 20.0),
                        child: Image.asset('asset/image/bigmac.png'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 0.0, left: 20.0),
                          child: Text('BigMac',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 42,
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 0.0),
                        child: Image.asset('asset/image/mcchicken.png'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 0.0, left: 20.0),
                          child: Text('McChicken',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 42,
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 15.0),
                        child: Image.asset('asset/image/McFries.png'),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(right: 0.0, left: 20.0, top: 0.0),
                          child: Text('Mc Fries',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 42,
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Container(
                height: 100.0,
                width: 100.0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: GestureDetector(
                      child: Image.asset('asset/image/Group 55.png'),
                      onTap: () {}),
                ))
          ],
        )),
      ),
    );
  }
}

class DoRatingFinal extends StatefulWidget {
  String value, image;

  DoRatingFinal({Key key, this.value, this.image}) : super(key: key);
  @override
  _DoRatingFinalState createState() => _DoRatingFinalState();
}

class _DoRatingFinalState extends State<DoRatingFinal> {
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('Edit Rating',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              alignment: Alignment(0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Text('McDonalds',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    alignment: Alignment(0.00, 0.0),
                    height: 200.0,
                    width: 200.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.asset('asset/image/mcdonalds.png'),
                    ),
                  ),
                  new Divider(),
                  Container(
                      child: Text('How would you like to rate this stall?',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 40.0, right: 0.0, left: 15.0),
                      child: Column(
                        children: <Widget>[
                          RatingBar(
                            onRatingChanged: (rating) =>
                                setState(() => rating = rating),
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            halfFilledIcon: Icons.star_half,
                            isHalfAllowed: true,
                            filledColor: Colors.amber,
                            emptyColor: Colors.amber,
                            halfFilledColor: Colors.amber,
                            size: 42,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 150.0, width: 40.0),
                  // Container(
                  //   height: 70,
                  //   width: 250,
                  //   child: RaisedButton(
                  //     shape: new RoundedRectangleBorder(
                  //         borderRadius: new BorderRadius.circular(50.0),
                  //         side: BorderSide(color: Colors.red),
                  //         ),

                  //     onPressed: () {},
                  //     color: Colors.red,
                  //     textColor: Colors.white,
                  //     child: Text("Submit".toUpperCase(),
                  //         style: TextStyle(fontSize: 18)),
                  //   ),
                  // )
                  Container(
                    child: Transform.translate(
                        offset: Offset(0.0, 100.0),
                        child: RaisedButton(
                          onPressed: () {
                            AlertDialog(
                              content: Text(
                                'Success!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFAC0D57),
                                      Color(0xFFFC4A1F)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ))),
    );
  }
}

class TopRatedItems extends StatefulWidget {
  String value, image, vendorId;

  TopRatedItems({this.value, this.image, this.vendorId});

  @override
  _TopRatedItems createState() => new _TopRatedItems();
}

class _TopRatedItems extends State<TopRatedItems> {
  double myrating;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: FirestoreService().getItemInfo('${widget.vendorId}'),
      child: Scaffold(
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
                              padding: EdgeInsets.only(bottom: 60.0, left: 10),
                              child: Text('${widget.value}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Image.network('${widget.image}'),
                ),
                

           
              ),

              Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 50.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar.readOnly(
                          //Balaj chnage this line
                          initialRating: double.parse('3.8'),
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
              new Divider(),
              Row(
                children: <Widget>[
                   Container(
                child: GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Top Rated Items',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            )),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 60.0),
                    child: GestureDetector(
                      onTap: () {
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TopRatedItemsReviews(
                                  value: '${widget.value}',
                                  image: '${widget.image}'),
                        );
                        Navigator.of(context).push(route);
                      },
                      child: Text('Reviews',
                          style: TextStyle(color: Colors.red, fontSize: 22)),
                    ),
                  )
                ],
              ),
              ListItem(),
              // new Divider(),
            ],
          )),
        ),
      ),
    );
  }
}

class ChangeRatings extends StatefulWidget {
  String value, image;

  ChangeRatings({Key key, this.value, this.image}) : super(key: key);

  @override
  _ChangeRatings createState() => new _ChangeRatings();
}

class _ChangeRatings extends State<ChangeRatings> {
  double myrating;
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('${widget.value}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                child: Image.asset('${widget.image}'),
              ),
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Container(
                child: GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Top Rated Reviews',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 60.0),
                  child: Text('Reviews',
                      style: TextStyle(color: Colors.red, fontSize: 22)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 20.0),
                        child: Image.asset('asset/image/bigmac.png'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 0.0, left: 20.0),
                          child: Text('BigMac',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 40,
                        ),
                        // Text(
                        //   '$myrating/5',
                        //   style: TextStyle(color: Colors.black, fontSize: 15),
                        // )
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 0.0),
                        child: Image.asset('asset/image/mcchicken.png'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 0.0, left: 20.0),
                          child: Text('McChicken',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 40,
                        ),
                        // Text(
                        //   '$myrating/5',
                        //   style: TextStyle(color: Colors.black, fontSize: 15),
                        // )
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, left: 15.0),
                        child: Image.asset('asset/image/McFries.png'),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(right: 0.0, left: 20.0, top: 0.0),
                          child: Text('Mc Fries',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0, left: 65.0),
                    child: Column(
                      children: <Widget>[
                        RatingBar(
                          onRatingChanged: (rating) =>
                              setState(() => rating = rating),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 40,
                        ),
                        // Text(
                        //   '$myrating/5',
                        //   style: TextStyle(color: Colors.black, fontSize: 15),
                        // )
                      ],
                    ),
                  ),
                )),
              ],
            ),
            new Divider(),
            Container(
                height: 100.0,
                width: 100.0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: GestureDetector(
                      child: Image.asset('asset/image/Group 55.png'),
                      onTap: () {
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new EditRating1(
                              value: '${widget.value}',
                              image: '${widget.image}'),
                        );
                        Navigator.of(context).push(route);
                      }),
                ))
          ],
        )),
      ),
    );
  }
}

class TopRatedItemsReviews extends StatefulWidget {
  String value, image, vendorId;

  TopRatedItemsReviews({this.value, this.image, this.vendorId});

  @override
  _TopRatedItemsReviews createState() => new _TopRatedItemsReviews();
}

class _TopRatedItemsReviews extends State<TopRatedItemsReviews> {
  double myrating;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: FirestoreService().getItemInfo('${widget.vendorId}'),
      child: Scaffold(
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
                              padding: EdgeInsets.only(bottom: 60.0, left: 10),
                              child: Text('${widget.value}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28))),
                        )),
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFAC0D57),
                            Color(0xFFFC4A1F),
                          ]),
                      image: DecorationImage(
                        image: AssetImage(
                          "asset/image/Chat.png",
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              child: ListView(
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Image.network('${widget.image}'),
                ),
              ),
              RatingBar.readOnly(
                initialRating: 3.5,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                filledColor: Colors.amber,
                emptyColor: Colors.amber,
                halfFilledColor: Colors.amber,
                size: 36,
              ),
              new Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 20.0),
                    child: GestureDetector(
                      onTap: () {Navigator.pop(context);},
                    child: Text('Top Rated Items',
                        style: TextStyle(color: Colors.red, fontSize: 22)),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(right: 10.0, left: 60.0),
                  //   child: Text('Reviews',
                  //       style: TextStyle(color: Colors.red, fontSize: 22)),
                  // )
                  Container(
                child: GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 170.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Reviews',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ))
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 30.0, left: 15.0),
                          child: GestureDetector(
                              onTap: () {
                                print("Upload Photo");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/circular.png'),
                              ))),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 10.0),
                          child: Text('4.5/5'))
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 200.0,
                          maxWidth: 200.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          "The ambiance was Amazing. Good food. Good people. I would really like to come again",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Divider(),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 30.0, left: 15.0),
                          child: GestureDetector(
                              onTap: () {
                                print("Upload Photo");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/avatar.png'),
                              ))),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 10.0),
                          child: Text('2/5'))
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 200.0,
                          maxWidth: 200.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          "The chicken was a bit undercooked. The fries were not the way I wanted. Pls improve!",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Divider(),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 30.0, left: 15.0),
                          child: GestureDetector(
                              onTap: () {
                                print("Upload Photo");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/avatar1.png'),
                              ))),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 10.0),
                          child: Text('4.5/5'))
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 200.0,
                          maxWidth: 200.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          "Overall good service. I am satisfied.",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ViewReviews extends StatefulWidget {
  String value, image;

  ViewReviews({Key key, this.value, this.image}) : super(key: key);

  @override
  _ViewReviews createState() => new _ViewReviews();
}

class _ViewReviews extends State<ViewReviews> {
  double myrating;
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('${widget.value}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                child: Image.asset('${widget.image}'),
              ),
            ),
            RatingBar.readOnly(
              initialRating: 3.5,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledIcon: Icons.star_half,
              isHalfAllowed: true,
              filledColor: Colors.amber,
              emptyColor: Colors.amber,
              halfFilledColor: Colors.amber,
              size: 40,
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 20.0),
                    child: GestureDetector(
                      onTap: () {Navigator.pop(context);},
                    child: Text('My Ratings',
                        style: TextStyle(color: Colors.red, fontSize: 22)),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                child: GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 170.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('My Reviews',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            )),
                )
                
              ],
            ),

            Padding(
              padding: EdgeInsets.only (top: 15.0, right: 45.0, left: 45.0),
              child: Container(
                width: 200.0,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                   gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        //Colors.white,
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                        
                      ]),
                  color: Colors.redAccent,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/circular.png'),
                              )
                    ),

                    Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,

                ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 200.0,
                          maxWidth: 270.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          "The burger of McDonalds were juicy and tendor, the ambiance was great I would love to come again",
                          
                          style: TextStyle(fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  ],
                )
              )
            )
            
                
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Color(0xFFFC4A1F),
        onPressed: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new EditReviews(
                value: '${widget.value}', image: '${widget.image}'),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class EditReviews extends StatefulWidget {
  String value, image;

  EditReviews({Key key, this.value, this.image}) : super(key: key);

  @override
  _EditReviews createState() => new _EditReviews();
}

class _EditReviews extends State<EditReviews> {
  double myrating;
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
                            padding: EdgeInsets.only(bottom: 60.0, left: 10),
                            child: Text('${widget.value}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28))),
                      )),
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                )
              ],
            ),
            clipper: Clipshape(),
          )),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                child: Image.asset('${widget.image}'),
              ),
            ),
            RatingBar.readOnly(
              initialRating: 3.5,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledIcon: Icons.star_half,
              isHalfAllowed: true,
              filledColor: Colors.amber,
              emptyColor: Colors.amber,
              halfFilledColor: Colors.amber,
              size: 40,
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 20.0),
                    child: GestureDetector(
                      onTap: () {Navigator.pop(context);},
                    child: Text('My Ratings',
                        style: TextStyle(color: Colors.red, fontSize: 22)),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                child: GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 170.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('My Reviews',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            )),
                )
                
              ],
            ),

            Padding(
              padding: EdgeInsets.only (top: 15.0, right: 45.0, left: 45.0),
              child: Container(
                width: 200.0,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                   gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        //Colors.white,
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                        
                      ]),
                  color: Colors.redAccent,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/circular.png'),
                              )
                    ),

                    Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,

                ),
    
                        child: TextFormField(    
                        
                           decoration: InputDecoration(
                              labelText: 'Write a new review...',
                              contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0)
                            ),                       
                          style: TextStyle(
                            fontSize: 14.0,
                            height: 2.0,
                            color: Colors.black                  
                          )
                        ),
                      
                    ),
                  )
                  ],
                )
              )
            ),
            SizedBox(
              height: 30.0,
            ),
             Container(
                height: 100.0,
                width: 100.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
                  child: GestureDetector(
                      child: Image.asset('asset/image/Group 55.png'),
                      onTap: () {
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new EditRating1(
                              value: '${widget.value}',
                              image: '${widget.image}'),
                        );
                        Navigator.of(context).push(route);
                      }),
                ))
            
                
          ],
        )),
      ),
      
    );
  }
}
