import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/login.dart';
import 'package:rateit/ratedItem.dart';
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
import 'package:dropdownfield/dropdownfield.dart';
import 'item-list.dart';
import 'item.dart';
import 'edit-profile.dart';
import 'my-rating.dart';
import 'ratedVendor.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'rate-body-items.dart';
import 'editMyRatingItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'reviewfromdb.dart';

DateTime _dateTime;
String user_id;
UserData myUserInfo;

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
              backgroundImage: new NetworkImage('${myUserInfo.profilePicture}'),
            ),
            Text(myUserInfo.firstName + ' ' + myUserInfo.lastName,
                style: TextStyle(fontSize: 30, color: Colors.black)),
            Text(myUserInfo.email,
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
  void getUserInfo() async {
    // new method
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // getting locally stored data
    String uid = prefs.getString('uid');
    String firstName = prefs.getString('firstName');
    String lastName = prefs.getString('lastName');
    String email = prefs.getString('email');
    String profilePicture = prefs.getString('profilePicture');
    String gender = prefs.getString('gender');
    // Storing data in user class object
    myUserInfo = UserData(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        profilePicture: profilePicture);
  }

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
                        getUserInfo();
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

  List<String> genders = ['Male', 'Female', 'Other'];
  final genderSelected = TextEditingController();
  final formKey = new GlobalKey<FormState>();



  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Select'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        _openGallery(context);
                      }),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera(context);
                      })
                ],
              )));
        });
  }

  File _image;

  Future _openGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    String selectCity;

    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

   bool error1=true, error2=true;
   bool validate=false; 

  String _name, _email, _password, _gender;
  DateTime _dateOfBirth;

  final _formKey = GlobalKey<FormState>();
  final EditUserData _updateData = EditUserData();

  void submit() {
    _formKey.currentState.save();
    _updateData.update(
        user_id, _name, _email, _password, _gender, _dateOfBirth);
    // TODO: Send an alert that data updated
  }

  List<DropdownMenuItem<String>> n = [];
  void loadData() {
    n = [];
    n.add(new DropdownMenuItem(child: new Text('Male'), value: 'Male'));
    n.add(new DropdownMenuItem(child: new Text('Female'), value: 'Female'));
    n.add(new DropdownMenuItem(child: new Text('Other'), value: 'Other'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
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
                                  padding:
                                      EdgeInsets.only(bottom: 300.0, left: 18),
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
                                    backgroundImage: NetworkImage(
                                        '${myUserInfo.profilePicture}'),
                                  ))),
                          Container(
                              child: Transform.translate(
                                  offset: Offset(50.0, -60.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _showChoiceDialogue(context);
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Transform.translate(
                                  offset: Offset(0.0, -50.0),
                                  child: Text(
                                      myUserInfo.firstName +
                                          ' ' +
                                          myUserInfo.lastName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )))),
                          Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Transform.translate(
                                  offset: Offset(0.0, -50.0),
                                  child: Text(myUserInfo.email,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )))),
                        ],
                      )
                    ],
                  ),
                  clipper: Clipshape(),
                )),
            endDrawer: SideBar2(),
            body: Container(
              child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.person, color: Color(0xFFFC4A1F)),
                          title: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Edit Username',
                              hintText: myUserInfo.firstName +
                                  ' ' +
                                  myUserInfo.lastName,
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          //trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                          onTap: () {}),
                    ),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.lock_outline,
                              color: Color(0xFFFC4A1F)),
                          title: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Change Password',
                              hintText: '*********',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          //trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                          onTap: () {
                            TextField();
                          }),
                    ),
                    Card(
                        child: ListTile(
                            leading: Icon(Icons.mail, color: Color(0xFFFC4A1F)),
                            title: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Update Email',
                                hintText: myUserInfo.email,
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ))),
                    // Card(
                    //   child: ListTile(
                    //       leading:
                    //           Icon(Icons.hot_tub, color: Color(0xFFFC4A1F)),
                    //       title: Text('Gender'),
                    //       // trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                    //       onTap: () {
                    //         DropdownButton<String>(
                    //           value: _gender,
                    //           items: n,
                    //           onChanged: (value) {
                    //             _gender = value;
                    //             //error1=false;
                    //             setState(() {});
                    //           },
                    //         );
                    //       }),
                    // ),
                     
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.calendar_today,
                            color: Color(0xFFFC4A1F)),
                        title: RaisedButton(
                            color: Colors.white,
                            child: Text(
                                _dateTime == null
                                    ? 'DD-MM-YYYY'
                                    : DateFormat('dd-MM-yyyy')
                                        .format(_dateTime),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            onPressed: () {
                              //print('here');
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                  builder:
                                      (BuildContext context, Widget child) {
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
                            }
                            // trailing: Icon(Icons.edit, color: Color(0xFFFC4A1F)),
                            // onTap: () {

                            // }
                            ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                          leading: Icon(Icons.lock_outline,
                              color: Color(0xFFFC4A1F)),
                          title: DropDownField(
                          controller: genderSelected,
                          hintText: 'Please select your Gender',
                          enabled: true,
                          items: genders,
                          onValueChanged: (value)
                          {
                            setState((){
                             // selectCity = value;
                            });
                          }

                        )
                      ),
                    ),
                     SafeArea(
                child: InkWell(
                  onTap: () async{
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Details have been saved successfully!"),
                          actions: <Widget>[
                            Center(
                              child: FlatButton(
                                onPressed: ()=>Navigator.of(context).pop(false),
                                child: Text("Ok"),
                              )
                            )
                          ],
                        ); 
                      },
                    );
                  },

                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 40, right: 40.0, left: 40.0), 
                  child: Container(
                    height: 50,
                    width: 350,
                    
                    
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [ 
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.only(top: 15, left: 135), 
                    child: Text("Submit",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),

                  ]),
            )));
  }
}



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

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
            String scanning = "";
            scanning  = await BarcodeScanner.scan();
            String name, logo;
            await FirestoreService()
                .getVendor(scanning)
                .then((docs) {
              if (docs.documents.isNotEmpty) {
                name = docs.documents[0].data['name'];
                logo = docs.documents[0].data['logo'];
              }
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DoRatings(
                        name: name,
                        logo: logo,
                        vendorId: scanning)));
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

  String qr = "";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedVendor>>.value(
      value: FirestoreService().getMyRatedVendor(user_id),
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
        body: RatedVendorList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[800],
          child: Image.asset("asset/image/Camera 1.png"),
          onPressed: () async {
            //Navigator.of(context).pushNamed('/doratings');
            String scanning = "";
            scanning  = await BarcodeScanner.scan();
            String name, logo;
            await FirestoreService()
                .getVendor(scanning)
                .then((docs) {
              if (docs.documents.isNotEmpty) {
                name = docs.documents[0].data['name'];
                logo = docs.documents[0].data['logo'];
              }
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DoRatings(
                        name: name,
                        logo: logo,
                        vendorId: scanning)));
          },
        ),
      ),
    );
  }
}

class EditRatings extends StatefulWidget {
  String name, image, rating, vendorId, reviewId;

  EditRatings(
      {this.name, this.image, this.rating, this.vendorId, this.reviewId});

  @override
  _EditRatings createState() => new _EditRatings();
}

class _EditRatings extends State<EditRatings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedItem>>.value(
      value: FirestoreService().getMyRatedItem(user_id, '${widget.vendorId}'),
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
                                padding:
                                    EdgeInsets.only(bottom: 60.0, left: 10),
                                child: Text('${widget.name}',
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Container(
                              child: GestureDetector(
                            onTap: () {},
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
                                child: Text('My Ratings',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 60.0),
                          child: GestureDetector(
                            onTap: () async {
                              // get review
                              String review = await FirestoreService()
                                  .getReview(widget.reviewId);
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) => new ViewReviews(
                                  value: '${widget.name}',
                                  image: '${widget.image}',
                                  reviewId: '${widget.reviewId}',
                                  review: review,
                                ),
                              );
                              Navigator.of(context).push(route);
                            },
                            child: Text('Reviews',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 22)),
                          ),
                        ),
                      ],
                    ),
                    RatedItemList(),
                  ],
                ),
              )),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            backgroundColor: Color(0xFFFC4A1F),
            onPressed: () {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new ChangeRatings(
                    value: '${widget.name}',
                    image: '${widget.image}',
                    vendorId: '${widget.vendorId}',
                    reviewId: '${widget.reviewId}'),
              );
              Navigator.of(context).push(route);
            },
          )),
    );
  }
}

class EditRating1 extends StatefulWidget {

  String name, logo, vendorId, review, reviewId;
  List<Map> list;

  EditRating1({Key key, this.name, this.logo, this.vendorId, this.review, this.list, this.reviewId}) : super(key: key);
  @override
  _EditRating1State createState() => _EditRating1State();
}

class _EditRating1State extends State<EditRating1> {

  double finalRating;

  void submit(double finalRating) {
    var error = FirestoreService().updateRatings(user_id, widget.list,widget.vendorId, widget.review, widget.reviewId, finalRating);
    if (error != null) {
      print(error);
    }
  }


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
                      child: Text('${widget.name}',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    alignment: Alignment(0.00, 0.0),
                    height: 200.0,
                    width: 200.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.network('${widget.logo}'),
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
                                setState(() => finalRating = rating),
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
                   SafeArea(
                child: InkWell(
                  onTap: () async{
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Success!"),
                          actions: <Widget>[
                            Center(
                              child: FlatButton(
                                onPressed: ()=>Navigator.of(context).pop(false),
                                child: Text("ok"),
                              )
                            )
                          ],
                        ); 
                      },
                    );
                  },

                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 40), 
                  child: Container(
                    height: 50,
                    width: 350,
                    
                    
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [ 
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.only(top: 15, left: 140), 
                    child: Text("Submit",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),
                  
                ],
              ))),
    );
  }
}

class DoRatings extends StatefulWidget {
  String name, logo, vendorId;
  List<Map> list;

  DoRatings({this.name, this.logo, this.vendorId, this.list});

  @override
  _DoRatings createState() => new _DoRatings();
}

class _DoRatings extends State<DoRatings> {
  List<Map> myRatingInfo = new List();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: FirestoreService().getAllItemInfo('${widget.vendorId}'),
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
                              child: Text('${widget.name}',
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
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                  child: ListView(children: <Widget>[
                Container(
                  height: 200.0,
                  width: 200.0,
                  child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.network('${widget.logo}')),
                ),
                new Divider(),
                DisplayItems(list: myRatingInfo),
                Container(
                    height: 100.0,
                    width: 100.0,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: GestureDetector(
                          child: Image.asset('asset/image/Group 55.png'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoReviews(
                                          name: '${widget.name}',
                                          logo: '${widget.logo}',
                                          vendorId: '${widget.vendorId}',
                                          list: myRatingInfo,
                                        )));
                          }),
                    ))
              ])))),
    );
  }
}

class DoRatingFinal extends StatefulWidget {
  String name, logo, vendorId, review;
  List<Map> list;

  DoRatingFinal({this.name, this.logo, this.vendorId, this.list, this.review});
  @override
  _DoRatingFinalState createState() => _DoRatingFinalState();
}

class _DoRatingFinalState extends State<DoRatingFinal> {
  double finalRating;

  void submit(double finalRating) {
    var error = FirestoreService().sendRatings(user_id, widget.list,
        widget.name, widget.logo, widget.vendorId, widget.review, finalRating);
    if (error != null) {
      print(error);
    }
  }

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
                            child: Text('Rating a Vendor',
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
                      child: Text('${widget.name}',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                  Container(
                    alignment: Alignment(0.00, 0.0),
                    height: 200.0,
                    width: 200.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.network('${widget.logo}'),
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
                            onRatingChanged: (rating) => finalRating = rating,
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
                   SafeArea(
                child: InkWell(
                  onTap: () async{
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Success!"),
                          actions: <Widget>[
                            Center(
                              child: FlatButton(
                                onPressed: ()=>Navigator.of(context).pop(false),
                                child: Text("ok"),
                              )
                            )
                          ],
                        ); 
                      },
                    );
                  },

                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 40), 
                  child: Container(
                    height: 50,
                    width: 350,
                    
                    
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [ 
                          Color(0xFFAC0D57),
                          Color(0xFFFC4A1F),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.only(top: 15, left: 140), 
                    child: Text("Submit",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),
                  
                ],
              ))),
    );
  }
}

class TopRatedItems extends StatefulWidget {
  String value, image, vendorId, vendorRating;

  TopRatedItems({this.value, this.image, this.vendorId, this.vendorRating});

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
                      initialRating: double.parse('${widget.vendorRating}'),
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
                    onTap: () {},
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
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
                                  image: '${widget.image}', 
                                  vendorId: '${widget.vendorId}',
                                  vendorRating: '${widget.vendorRating}',
                              ),
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
  String value, image, vendorId, reviewId;

  ChangeRatings({Key key, this.value, this.image, this.vendorId, this.reviewId})
      : super(key: key);

  @override
  _ChangeRatings createState() => new _ChangeRatings();
}

class _ChangeRatings extends State<ChangeRatings> {
  List<Map> myEditedRating = new List();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedItem>>.value(
        value: FirestoreService().getMyRatedItem(user_id, widget.vendorId),
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
                                  padding:
                                      EdgeInsets.only(bottom: 60.0, left: 10),
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
                child: ListView(children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 200.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Image.network('${widget.image}'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child:Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: Text('${widget.value}',
                            style: TextStyle(fontSize: 25, color: Colors.black))))),                  
                  EditMyRatingsItems(list: myEditedRating,),
                  new Divider(),
                  Container(
                      height: 100.0,
                      width: 100.0,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                            child: Image.asset('asset/image/Group 55.png'),
                            onTap: () async {
                              String review = await FirestoreService()
                                  .getReview(widget.reviewId);
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new EditReviews(
                                        name: widget.value,
                                        logo: widget.image,
                                        vendorId: widget.vendorId,
                                        review: review,
                                        reviewId: widget.reviewId,
                                        list: myEditedRating),
                              );
                              Navigator.of(context).push(route);
                            }),
                      ))
                ]),
              ),
            )));
  }
}

class TopRatedItemsReviews extends StatefulWidget {
  String value, image, vendorId, vendorRating;

  TopRatedItemsReviews({this.value, this.image, this.vendorId, this.vendorRating});

  @override
  _TopRatedItemsReviews createState() => new _TopRatedItemsReviews();
}

class _TopRatedItemsReviews extends State<TopRatedItemsReviews> {
  double myrating;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Review>>.value(
      value: FirestoreService().getAllVendorReviews('${widget.vendorId}'),
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
                initialRating: double.parse('${widget.vendorRating}'),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                    onTap: () {},
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ))
                ],
              ),
              ReviewFromDB(),
            ],
          )),
        ),
      ),
    );
  }
}

class ViewReviews extends StatefulWidget {
  String value, image, reviewId, review, vendorId;

  ViewReviews({Key key, this.value, this.image, this.reviewId, this.review, this.vendorId})
      : super(key: key);

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
              size: 40,
            ),
            new Divider(),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                    onTap: () {},
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  )),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 15.0, right: 45.0, left: 45.0),
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
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 10.0),
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
                                    child: AutoSizeText( widget.review,
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ))),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Color(0xFFFC4A1F),
        onPressed: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new ChangeRatings(
                value: widget.value,
                image: widget.image,
                vendorId: widget.vendorId,
                reviewId: '${widget.reviewId}', 
                ),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}

class EditReviews extends StatefulWidget {
  String name, logo, reviewId, review, vendorId;
  List<Map> list;

  EditReviews({Key key, this.name, this.logo, this.vendorId,  this.reviewId, this.review, this.list})
      : super(key: key);

  @override
  _EditReviews createState() => new _EditReviews();
}

class _EditReviews extends State<EditReviews> {
  double myrating;

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

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
            child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                child: Image.network('${widget.logo}'),
              ),
            ),
            Container(
                    child: Center(
                      child:Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: Text('${widget.name}',
                            style: TextStyle(fontSize: 25, color: Colors.black))))),
            Padding(
                padding: EdgeInsets.only(top: 15.0, right: 45.0, left: 45.0),
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
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                                onChanged: (rev) => widget.review = rev,
                                focusNode: myFocusNode,
                                decoration: InputDecoration(
                                    labelText: widget.review,
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black)),
                          ),
                        )
                      ],
                    ))),
            Container(
                child: Transform.translate(
                    offset: Offset(150.0, -30.0),
                    child: MaterialButton(
                      onPressed: () => myFocusNode.requestFocus(),
                      color: Color(0xFFFC4A1F),
                      textColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ))),
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
                              name: widget.name,
                              logo: widget.logo,
                              vendorId: widget.vendorId,
                              review: widget.review,
                              reviewId: widget.reviewId,
                              list: widget.list,
                              ),
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

class DoReviews extends StatefulWidget {
  String name, logo, vendorId;
  List<Map> list;

  DoReviews({this.name, this.logo, this.vendorId, this.list});

  @override
  _DoReviews createState() => new _DoReviews();
}

class _DoReviews extends State<DoReviews> {
  
  String review;

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

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
                            child: Text('${widget.name}',
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
                child: Image.network('${widget.logo}'),
              ),
            ),
            new Divider(),
            Padding(
                padding: EdgeInsets.only(top: 15.0, right: 45.0, left: 45.0),
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
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                                onChanged: (rev) => review = rev,
                                focusNode: myFocusNode,
                                decoration: InputDecoration(
                                    labelText: 'Write a new review...',
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 2.0,
                                    color: Colors.black)),
                          ),
                        )
                      ],
                    ))),
            Container(
                child: Transform.translate(
                    offset: Offset(150.0, -30.0),
                    child: MaterialButton(
                      onPressed: () => myFocusNode.requestFocus(),
                      color: Color(0xFFFC4A1F),
                      textColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ))),
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
                            builder: (BuildContext context) =>
                                new DoRatingFinal(
                                  name: '${widget.name}',
                                  logo: '${widget.logo}',
                                  vendorId: '${widget.vendorId}',
                                  list: widget.list,
                                  review: review,
                                ));
                        Navigator.of(context).push(route);
                      }),
                )),
          ],
        )),
      ),
    );
  }
}




