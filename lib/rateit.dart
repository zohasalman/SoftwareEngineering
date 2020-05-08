import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateit/login.dart';
import 'package:rateit/ratedItem.dart';
import 'firestore.dart';
import 'dart:math' as math;
import 'user.dart';
import 'vendor-list.dart';
import 'package:rating_bar/rating_bar.dart';
import 'item-list.dart';
import 'item.dart';
import 'ratedVendor.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'rate-body-items.dart';
import 'editMyRatingItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reviewfromdb.dart';
import 'package:location/location.dart';
import 'EditProfile.dart';

String userID, eName, eId;
UserData myUserInfo;

void main3() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: <String, WidgetBuilder>{ //routes for switching around the rateit UI.
          "/rateitfirst": (BuildContext context) => new _RateItFirstScreen(),
          "/rateitsecond": (BuildContext context) => new ViewVendor(),
          '/EditProfileScreen': (BuildContext context) => new EditProfile(),
          '/Viewratings': (BuildContext context) => new ViewMyRating(),
          '/editrating1': (BuildContext context) => new EditRating1(),
          '/doratings': (BuildContext context) => new DoRatings(),
          '/changeratings': (BuildContext context) => new ChangeRatings(),
        }));


class SideBar1 extends StatefulWidget {
  @override
  SideBarProperties1 createState() => new SideBarProperties1();
}

class SideBarProperties1 extends State<SideBar1> { //SideBar class containing user info and buttons to editprofile
  void normalSignOut() async {                     //viewuserratings and signout.
    User usr = Provider.of<User>(context, listen: false);
    String user = usr.uid;
    userID = usr.uid;
    await FirestoreService(uid: user).normalSignOutPromise();
    LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea (
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:420),
            ),
            Container(                                        //button for Sign out 
                child: GestureDetector(
              onTap: () async {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                await FirestoreService().normalSignOutPromise();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginScreen()),
                // );
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
                  child: Text('Sign Out',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            )),
          ])),
    );
  }
}        

class SideBar2 extends StatefulWidget {
  @override
  SideBarProperties2 createState() => new SideBarProperties2();
}

class SideBarProperties2 extends State<SideBar2> { //SideBar class containing user info and buttons to editprofile
  void normalSignOut() async {                     //viewuserratings and signout.
    User usr = Provider.of<User>(context, listen: false);
    String user = usr.uid;
    userID = usr.uid;
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
              backgroundImage: NetworkImage('${myUserInfo.profilePicture}' ?? ''), //User Picture from databse
            ),
            Text(myUserInfo.firstName + ' ' + myUserInfo.lastName, //User Name coming from database
                style: TextStyle(fontSize: 30, color: Colors.black)),
            Text(myUserInfo.email,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.black)),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          new EditProfile(userInfoRecieved: myUserInfo)),// Switching to Edit Profie screen
                );
              },
              child: Container(                                   //button for Edit Profile Screen
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
            Container(                                  //button for View My Rating Screen
                child: GestureDetector(
              onTap: () {
                //Navigator.popUntil(context, ModalRoute.withName('/Viewratings'));
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
            Container(                                        //button for Sign out 
                child: GestureDetector(
              onTap: () async {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                await FirestoreService().normalSignOutPromise();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginScreen()),
                //);
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

class _InviteScreen extends State<InviteScreen> {         //Class for invite screen where user enters Invite Code
  String inviteCode = '';
  String errorMessage = '';
  bool ifError = false;
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirestoreService();

  Future<void> submitInviteCode() async {                     //On Submit, the location of user is verified in this function
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String eventName = '';
      String eventID = '';
      bool serviceCheck = await Location().serviceEnabled(), locationEnabled=true;
      double currentLatitude;
      double currentLongitude;
      double eventLatitude;
      double eventLongitude;
      if(!serviceCheck) {
        if( !(await Location().requestService()) ){
          locationEnabled=false;
        }
      }
      if( PermissionStatus.denied == await Location().hasPermission()) {
        if( PermissionStatus.granted != await Location().requestPermission() ) {
          locationEnabled=false;
        }
      }
      if(locationEnabled) {
        LocationData locationData = await Location().getLocation();
        currentLatitude = locationData.latitude/(180/math.pi);
        currentLongitude = locationData.longitude/(180/math.pi);
      }
      _firestore.verifyInviteCode(inviteCode).then((QuerySnapshot docs) {
        if (docs.documents.isNotEmpty && locationEnabled) {
          GeoPoint eventLocation = docs.documents[0].data['location1'];
          eventLatitude = eventLocation.latitude/(180/math.pi);
          eventLongitude = eventLocation.longitude/(180/math.pi);
          double diffLatitudeHalf=(eventLatitude-currentLatitude)/2;
          double diffLongitudeHalf=(eventLongitude-currentLongitude)/2;
          double distance = 2*6371.0710*math.asin( math.sqrt( (math.sin(diffLatitudeHalf)*math.sin(diffLatitudeHalf)) + ( (math.sin(diffLongitudeHalf)*math.sin(diffLongitudeHalf))*math.cos(currentLatitude)*math.cos(currentLongitude) ) ) ) * 1000; //Haversine Formula to calculate difference between coordinates
          //print('$distance,${eventLatitude*(180/math.pi)},${currentLatitude*(180/math.pi)}');

          // if (distance<=20000){  
            if (true) {        
            eventName = docs.documents[0].data['name'];
            eventID = docs.documents[0].data['eventID'];
            userID = '${widget.uid}';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _RateItFirstScreen(
                        eventName: eventName, eventID: eventID)));
          } else {
            errorMessage = 'You are out of the event area.';
            ifError =true;
            _formKey.currentState.validate();
          }
        }
        else if (docs.documents.isNotEmpty) {
          errorMessage = 'Location not enabled.';
          ifError =true;
          _formKey.currentState.validate();
        } 
        else {
          errorMessage = 'No such event invite code exists.';
        }
      });
    }
  }

  void getUserInfo() async {
    // new method
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // getting locally stored data
    String uid = prefs.getString('uid') ?? '';
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String email = prefs.getString('email') ?? '';
    String profilePicture = prefs.getString('profilePicture') ?? '';
    String gender = prefs.getString('gender') ?? '';
    // Storing data in user class object
    myUserInfo = UserData(
        uid: uid ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
        gender: gender ?? '',
        profilePicture: profilePicture) ?? '';
  }


  @override
  void initState() {
    super.initState();
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
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
                              child: Text('Invite code',
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
        endDrawer: SideBar1(),
        body: SafeArea(    
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                        child: TextFormField(                       //validating invite code here
                      cursorColor: Colors.pink,
                      validator: (value) {      
                        if (value.isEmpty) {
                          return 'Please enter invite code';
                        }
                        if (value.length > 6 || value.length < 6) {
                          return 'Invalid invite code';
                        }
                        if(ifError){
                          return errorMessage;
                        }
                        return null;
                      },
                      onSaved: (value) => inviteCode = value.trim(),
                      decoration: InputDecoration(
                          labelText: 'Enter invite code',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                            borderRadius: BorderRadius.circular(80.0),
                          )),
                    ))),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                SafeArea(
                    child: RaisedButton(
                  onPressed: () async {await submitInviteCode();},
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    width: 200,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFFAC0D57), Color(0xFFFC4A1F)],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ))
              ],
            ),
          ),
        ));
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

class RateItFirstScreen extends State<_RateItFirstScreen> {                   //Welcome Screen for the Food Event
  
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

class ViewVendor extends StatefulWidget {
  ViewVendor({this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  // String qr = "";

  @override
  State<StatefulWidget> createState() {
    return _ViewVendor();
  }
}

class _ViewVendor extends State<ViewVendor> {     //Class for View Vendor Screen displaying all the vendors in the events
                                                  //with their ratings
  String result;
  UserData userInfo;
  String qr = "";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    eName = widget.eventName;
    eId = widget.eventID;
  }

  @override
  Widget build(BuildContext context) {
    // final vendorFromDB = Provider.of<List<Vendor>>(context);

    return StreamProvider<List<Vendor>>.value(
      value: FirestoreService().getVendorInfo('${widget.eventID}'),  //Event ID coming from database
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
                              child: Text('${widget.eventName}',        //Event Name coming from database
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
        endDrawer: SideBar2(),        //SideBar called in this screen
        body: VendorsList(),          //Class to display to all the vendors in the file 'vendor-list.dart'
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[800],
          child: Image.asset("asset/image/Camera_1.png"),
          onPressed: () async {
            String scanning = "";
            scanning = await BarcodeScanner.scan();   //barcode scanner implemented to scan barcode of each vendor
            String name, logo;
            await FirestoreService().getVendor(scanning).then((docs) {
              if (docs.documents.isNotEmpty) {
                name = docs.documents[0].data['name'];
                logo = docs.documents[0].data['logo'];
              }
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DoRatings(name: name, logo: logo, vendorId: scanning))); //re-routing to barcode specific vendor screen

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

class _ViewMyRating extends State<ViewMyRating> {       //Class for screen where user can see the vendors he/she has rated
  String result;

  String qr = "";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedVendor>>.value(
      value: FirestoreService().getMyRatedVendor(userID),
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
            String scanning = "";
            scanning = await BarcodeScanner.scan();
            String name, logo;
            await FirestoreService().getVendor(scanning).then((docs) {
              if (docs.documents.isNotEmpty) {
                name = docs.documents[0].data['name'];
                logo = docs.documents[0].data['logo'];
              }
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DoRatings(name: name, logo: logo, vendorId: scanning)));
          },
        ),
      ),
    );
  }
}

class EditRatings extends StatefulWidget {  //Class for Screen where user can see the ratings of selected vendor
  final String name, image, rating, vendorId, reviewId;

  EditRatings(
      {this.name, this.image, this.rating, this.vendorId, this.reviewId});

  @override
  _EditRatings createState() => new _EditRatings();
}

class _EditRatings extends State<EditRatings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedItem>>.value(
      value: FirestoreService().getMyRatedItem(userID, '${widget.vendorId}'),  //vendor ID coming from firebase
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
                                child: Text('${widget.name}',  //vendor name switching between screens
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
          body: SafeArea(
              child: Padding(
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
                        RatingBar.readOnly(  //Rating bars to display rating as stars
                          initialRating: double.parse('${widget.rating}'),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          halfFilledColor: Colors.amber,
                          size: 36,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SafeArea(
                          child: Row(
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
                                              color: Colors.white,
                                              fontSize: 18)),
                                    ),
                                  ),
                                )),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 60.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    String review = await FirestoreService()
                                        .getReview(widget.reviewId); //review id of the user review from databases
                                    var route = new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new ViewReviews(
                                        value: '${widget.name}',
                                        image: '${widget.image}',
                                        reviewId: '${widget.reviewId}',
                                        vendorId: '${widget.vendorId}',
                                        review: review,
                                      ),
                                    );
                                    Navigator.of(context).push(route);
                                  },
                                  child: Text('Reviews',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 22)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        RatedItemList(),
                      ],
                    ),
                  ))),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            backgroundColor: Color(0xFFFC4A1F),
            onPressed: () {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new ChangeRatings(   //re-routing to the screen where user can edit ratings
                    value: '${widget.name}', //all details being sent to re-routed screen
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
  final String name, logo, vendorId, review, reviewId;
  final List<Map> list;

  EditRating1(
      {Key key,
      this.name,
      this.logo,
      this.vendorId,
      this.review,
      this.list,
      this.reviewId})
      : super(key: key);
  @override
  _EditRating1State createState() => _EditRating1State();
}

class _EditRating1State extends State<EditRating1> { //Screen where user will rate the vendor
  double finalRating;

  void submit(double finalRating) {
    var error = FirestoreService().updateRatings(userID, widget.list,
        widget.vendorId, widget.review, widget.reviewId, finalRating);
    if (error != null) {
      print(error);
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ViewVendor(eventName: eName, eventID: eId)),
        (Route<dynamic> route) => false);
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
      body: SingleChildScrollView(
      child: Padding(
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
                          RatingBar(   //Editable Rating bars to display rating as stars
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
                  SizedBox(height: 150.0, width: 40.0), //Sized boxes used at several places for gapping
                  
                  SafeArea(
                    child: InkWell(
                      onTap: () async {
                        submit(finalRating);
                        return await showDialog(    //Alert Box for acknowledgement
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Success!"),
                              actions: <Widget>[
                                Center(
                                    child: FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("ok"),
                                ))
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
                                    ]),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.only(top: 15, left: 140),
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))),
                        ),
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }
}

class DoRatings extends StatefulWidget {
  final String name, logo, vendorId;

  DoRatings({this.name, this.logo, this.vendorId});

  @override
  _DoRatings createState() => new _DoRatings();
}

class _DoRatings extends State<DoRatings> {  //Class for screen where the user will re-routed to after scanning barcode.
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
                            child: Container( 
                              width: MediaQuery.of(context).copyWith().size.width * 0.45,
                              child:Text('${widget.name}',
                                  style: TextStyle(
                                    color: Colors.white, fontSize: 28
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                              ),
                            ),
                          ),
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
                  //Functions to display vendor items
                
                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoReviews(
                                          name: '${widget.name}',
                                          logo: '${widget.logo}',
                                          vendorId: '${widget.vendorId}',
                                          list: myRatingInfo,
                                        )));
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  )),
                  Padding(padding: EdgeInsets.only(bottom: 10),)
              ])))),
    );
  }
}

class DoRatingFinal extends StatefulWidget {  //Class for screen to edit vendor
  final String name, logo, vendorId, review;
  final List<Map> list;

  DoRatingFinal({this.name, this.logo, this.vendorId, this.list, this.review});
  @override
  _DoRatingFinalState createState() => _DoRatingFinalState();
}

class _DoRatingFinalState extends State<DoRatingFinal> {
  double finalRating;

  void submit(double finalRating) {
    var error = FirestoreService().sendRatings(userID, widget.list, widget.name,
        widget.logo, widget.vendorId, widget.review, finalRating);
    if (error != null) {
      print(error);
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ViewVendor(eventName: eName, eventID: eId)),
        (Route<dynamic> route) => false);
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
      body: SingleChildScrollView(
      child:Padding(
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
                          RatingBar( //Editable Rating bars to display rating as stars
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
                  SafeArea(
                    child: InkWell(
                      onTap: () async {
                        submit(finalRating);
                        return await showDialog( //ALertBox for acknowledgement
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Success!"),
                              actions: <Widget>[
                                Center(
                                    child: FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("ok"),
                                ))
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
                                    ]),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.only(top: 15, left: 140),
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))),
                        ),
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }
}

class TopRatedItems extends StatefulWidget {
  final String value, image, vendorId, vendorRating;

  TopRatedItems({this.value, this.image, this.vendorId, this.vendorRating});

  @override
  _TopRatedItems createState() => new _TopRatedItems();
}

class _TopRatedItems extends State<TopRatedItems> { //Class for screen displaying top rated items of each vendor 
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
                              child: Text('${widget.value}',  // name of vendor coming from previous screen
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
              alignment: Alignment.center,
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
                padding: EdgeInsets.only(right: 0.0, left: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child:RatingBar.readOnly( //Read Only Rating bars to display rating as stars
                      initialRating: double.parse('${widget.vendorRating}'),
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: Colors.amber,
                      emptyColor: Colors.amber,
                      halfFilledColor: Colors.amber,
                      size: 36,
                    ),
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
                        child: Text('Top Rated Items',    //tabs to switch between items and reviews
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
              ListItem(),  //Function to display top rated items
             
            ],
          )),
        ),
      ),
    );
  }
}

class ChangeRatings extends StatefulWidget {
  final String value, image, vendorId, reviewId;

  ChangeRatings({Key key, this.value, this.image, this.vendorId, this.reviewId})
      : super(key: key);

  @override
  _ChangeRatings createState() => new _ChangeRatings();
}

class _ChangeRatings extends State<ChangeRatings> { //Class to display items and their editable rating bars. User can edit their ratings
  List<Map> myEditedRating = new List();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RatedItem>>.value(
        value: FirestoreService().getMyRatedItem(userID, widget.vendorId),
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
                          child: Padding(
                              padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                              child: Text('${widget.value}',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black))))),
                  EditMyRatingsItems(  //function to edit ratings of items
                    list: myEditedRating,
                  ),
                  new Divider(),
                   Container(
                                  child: MaterialButton(
                                    onPressed: () async {
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
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  )),
                  Padding(padding: EdgeInsets.only(bottom: 10),)
                  
                ]),
              ),
            )));
  }
}

class TopRatedItemsReviews extends StatefulWidget {
  final String value, image, vendorId, vendorRating;

  TopRatedItemsReviews(
      {this.value, this.image, this.vendorId, this.vendorRating});

  @override
  _TopRatedItemsReviews createState() => new _TopRatedItemsReviews();
}

class _TopRatedItemsReviews extends State<TopRatedItemsReviews> { //Class for displaying top rated reviews of each vendor
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
                initialRating: (double.parse('${widget.vendorRating}')),
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
              ReviewFromDB(), //User can edit reviews here
            ],
          )),
        ),
      ),
    );
  }
}

class ViewReviews extends StatefulWidget {
  final String value, image, reviewId, review, vendorId;

  ViewReviews(
      {Key key,
      this.value,
      this.image,
      this.reviewId,
      this.review,
      this.vendorId})
      : super(key: key);

  @override
  _ViewReviews createState() => new _ViewReviews();
}

class _ViewReviews extends State<ViewReviews> {  //Class for screen where user can see their reviews
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
            RatingBar.readOnly( //Non-Editable Rating bars to display rating as stars
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
                                    child: AutoSizeText(
                                      widget.review,
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
            builder: (BuildContext context) => new EditReviews(
              name: widget.value,
              logo: widget.image,
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
  final String name, logo, reviewId, vendorId;
  final List<Map> list;
  
  String review;

  EditReviews(
      {Key key,
      this.name,
      this.logo,
      this.vendorId,
      this.reviewId,
      this.review,
      this.list})
      : super(key: key);

  @override
  _EditReviews createState() => new _EditReviews(review: review);
}

class _EditReviews extends State<EditReviews> {     // User can make edits to their reviews here
  double myrating;
  FocusNode myFocusNode;
  String review;
  _EditReviews({this.review});
  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {   // Clean up the focus node when the Form is disposed.
   
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
                    child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: Text('${widget.name}',
                            style: TextStyle(
                                fontSize: 25, color: Colors.black))))),
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
                            child: TextFormField(  //editable textfield of review
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
                                  child: MaterialButton(
                                    onPressed: () {
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
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  )),
                  Padding(padding: EdgeInsets.only(bottom: 10),)
            
          ],
        )),
      ),
    );
  }
}

class DoReviews extends StatefulWidget {  //Class for screen where user can do reviews for vendors after scanning barcod 
  final String name, logo, vendorId; 
  final List<Map> list;

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
                                decoration: InputDecoration(  // User can write a new review
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
                                  child: MaterialButton(
                                    onPressed: () {
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
                                    },
                                    color: Color(0xFFFC4A1F),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 24,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  )),
                  Padding(padding: EdgeInsets.only(bottom: 10),)
          ],
        )),
      ),
    );
  }
}
