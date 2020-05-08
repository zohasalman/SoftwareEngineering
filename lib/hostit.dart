//Import all the required libraries and the files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'package:provider/provider.dart';
import 'localData.dart';
import 'user.dart';
import 'Event.dart';
import 'dart:convert';
import 'Clipshape.dart';
import 'package:random_string/random_string.dart';
import 'item.dart';
import 'vendorlist-hostit.dart';
import 'item-list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'userRedirection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rateit.dart';
import 'EditProfile.dart';


UserData myUserInfo;
void main2() => runApp(App());

String number=""; 

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    theme:  ThemeData(
          primaryColor: Colors.pink,
    ),
    debugShowCheckedModeBanner:  false,
    home:  AddEvent(coord: null),
    );
  }
}


class HostitHomescreen extends StatefulWidget {
  @override
  HostitHomescreenState createState() => HostitHomescreenState();
}
//homescreen of the hostit part of the application
class HostitHomescreenState extends State<HostitHomescreen> {
  var scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async{

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
        profilePicture: profilePicture ?? ''
        );
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
      value: FirestoreService().getEventsInfo(Provider.of<User>(context, listen: false).uid.toString()),
      child: Scaffold( 
        endDrawer: SideBar(),          //calling the sidebar drawer widget
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppBar(                 //displays the design bar of the screen
                  centerTitle: true,
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 40.0, left: 10),
                            child: Text('My Events',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                      )
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState.openEndDrawer();       //calling the enddrawer function to open the sidebar on clicking
                        },
                        child: Icon(
                          Icons.menu,       
                        ),
                      )
                    ),
                  ],
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            EventsListHostit(),
          ],
        ),
        floatingActionButton: SizedBox(width: 65,height: 65,
          child: FloatingActionButton(
            onPressed: () async {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> AddEvent(myUserInfo: myUserInfo, coord: null,)),);
            },
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width:65,
                height:65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: null,
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                  ),
                  child:
                    Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//description and declaration of the sidebar widget
class SideBar extends StatefulWidget {
  @override
  SideBarProperties createState() => new SideBarProperties();
}

class SideBarProperties extends State<SideBar>{

  UserData variable;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      Map<String, dynamic> userMap = json.decode(value);
      UserData finalObject = UserData.fromData(userMap);
      variable=finalObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(                                //the properties of the sidebar drawer
      child: new Column(
        
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Padding( padding: EdgeInsets.all(30),),
            CircleAvatar(                         //adding the profile image to the sidebar
              radius:70, 
              backgroundImage: NetworkImage('${myUserInfo.profilePicture}'),
            ),
            Text(                                 //displaying the name on the sidebar
              myUserInfo.firstName + ' ' + myUserInfo.lastName, 
              style: TextStyle(fontSize: 30, color: Colors.black)
            ),
            Text(                                 //displaying the user image on the sidebar
              myUserInfo.email, 
              style: TextStyle(fontSize: 22, color: Colors.black)
            ),
          Padding( padding: EdgeInsets.all(30),),
          Container(
            child: GestureDetector(             //leading to the edit profile screen
              onTap: () { //Change on Integration
                Navigator.push(context,MaterialPageRoute(builder: (context)=> EditProfile(userInfoRecieved: myUserInfo)),);
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
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Edit Profile',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
          Padding( padding: EdgeInsets.all(20),),
          Container(
            child: GestureDetector(             //signout from the application
              onTap:() async {
                try {
                  await FirestoreService().normalSignOutPromise();
                } catch (e) {
                  print(e);
                }
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
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Sign Out',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}
//displaying the event list for the main screen of the host it application
class EventsListHostit extends StatefulWidget {
  @override
  EventsListStateHostItState createState() => EventsListStateHostItState();
}

class EventsListStateHostItState extends State<EventsListHostit> {
  String err;
  
  @override
  Widget build(BuildContext context) {

    final events = Provider.of<List<Event>>(context);//fetching the event infor for the applications
    if (events == null){
      return LoadingScreen();                       //loading screen while the data is being fetched
    }else{
      return Expanded(
          child: 
          ListView.builder(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(               //lead to the event page 
                  onTap: () async {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:events[index].eventID,eventName:events[index].name,inviteCode:events[index].invitecode, userInfo: myUserInfo,)),);
                  },
                  onLongPress: ()async {              //prompting a dialogue box to delete the event
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Confirm"),
                          content: Text("Are you sure you want to delete this vendor?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {       //updating the direstore cloud in case of deletion
                                await Firestore.instance.collection('Event').document(events[index].eventID).delete().then((_) async {
                                  await Firestore.instance.collection('Vendor').where('eventId', isEqualTo: events[index].eventID).getDocuments().then((ven) async{
                                    ven.documents.forEach((vendoc) async {
                                      await Firestore.instance.collection('Vendor').document(vendoc.documentID).delete().then((_)async{
                                        await Firestore.instance.collection('ratedVendor').where('vendorId', isEqualTo: vendoc.documentID).getDocuments().then((val) async{
                                          val.documents.forEach((doc) async {
                                            await Firestore.instance.collection('ratedVendor').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                          });
                                        }).catchError((e){err=e.toString();});
                                        await Firestore.instance.collection('item').where('vendorId', isEqualTo: vendoc.documentID).getDocuments().then((val) async{
                                          val.documents.forEach((doc) async {
                                            await Firestore.instance.collection('item').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                          });
                                        }).catchError((e){err=e.toString();});
                                        await Firestore.instance.collection('ratedItems').where('vendorId', isEqualTo: vendoc.documentID).getDocuments().then((val) async{
                                          val.documents.forEach((doc) async {
                                            await Firestore.instance.collection('ratedItems').document(doc.documentID).delete().catchError((e){err=e.toString();});
                                          });
                                        }).catchError((e){err=e.toString();});
                                      }).catchError((e){err=e.toString();});
                                    });
                                  }).catchError((e){err=e.toString();});

                                });
                                Navigator.of(context).pop(false);
                              },
                              child: Text("Delete"),
                            ),
                            FlatButton(           //cancelling the deletion dialogue box
                              onPressed: ()=>Navigator.of(context).pop(false),
                              child: Text("Cancel"),
                            )
                          ],
                        ); 
                      },
                    ); 
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: CircleAvatar(          //adding the event logo
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: ClipOval(
                                    child: Image.network(
                                      '${events[index].logo}',
                                    ),
                                ),
                              ),
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                shape:BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(                      //displaying the event title
                            padding: EdgeInsets.only(left:10.0),
                            child: Text(
                              events[index].name,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  events[index].coverimage,       //displaying the event cover picture
                                ),
                                height: 200,
                                width: 350,
                              ),
                            ),
                          )
                        ],
                      ),
                      SafeArea(
                        child: err== null ? Container() : Container(
                          
                          padding:EdgeInsets.only( top: 5), 
                          child: Column(
                            children: <Widget>[
                              
                              Container(
                                alignment: Alignment(-0.8,-0.9),
                                  child: Text(err,
                                  style: TextStyle(color: Colors.red)
                                  ),
                              ),
                            ],
                          )                        
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        );
    }
  }
}

class AddEvent extends StatefulWidget {  //Add events screen which adds an event when clicked 
  final LatLng coord;
  final UserData myUserInfo;
  AddEvent({this.coord, this.myUserInfo});
  
  @override 
  AddEventState createState()=> new AddEventState(coord: coord); 
}

class AddEventState extends State<AddEvent> {
  LatLng coord;
  AddEventState({this.coord});
  int eventNumber;
  String name,logo, photo;  
  String err;
  bool validate=false, error1=false, error2=false;

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  
  void getCoordinates() async {                   //returns the coordinates that have been inputted by the user from the location screen
    final updatedcoord = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => Maps()
      ),
    );
    coord=updatedcoord;
  }
 
  
  @override
  void initState() {                          //Sets the user information
    super.initState();
    myUserInfo = widget.myUserInfo;
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(                
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[                           //AppBar displays the design bar of our screen
                AppBar(
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.0, left: 10),
                        child: Text('Add Event',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ), 
                    onPressed: () {
                       Navigator.push(context,MaterialPageRoute(builder: (context)=> HostitHomescreen()),);
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
            clipper: ClipShape(),
          )
        ),
      body: Form(
        key: _formKey,
        autovalidate: validate,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(                                                              //First field: Entering the name of the event at the top of the screen 
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              padding:EdgeInsets.only( top: 10, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input.isEmpty? 'Please fill out this field': null,           //Validation checks to prevent null values 
                    onChanged: (input)=> name=input,
                    decoration: InputDecoration(
                      labelText: 'Name of the event',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
                ],
              )
            ),
            Container(                                                          //Getting event location field
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                      child: TextFormField(
                        validator: (_) => coord==null  ? 'Please Mark a Location': null,            //If not entered anything then message to input the value
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: coord==null?'Location of Event':'(${coord.latitude},${coord.longitude})',   
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19
                          )
                        ),
                      )
                ),
                Container(                                                          //Location icon to direct to the location page
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center(child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add_location,
                      color: Colors.white,),
                      onPressed: () {
                        getCoordinates();       //Function that enables the coordinates from the map drawn 
                      },
                    ),
                  ),),
                )
              ],),
            ),
            Container(                                    //User handling message to make it user friendly as only those users can rate the event if they near 200 m of the event location 
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              padding: EdgeInsets.only(top: 0, left: 20), 
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "*Only users within 20 kilometres from location coordinates will be able to rate",style: TextStyle(color: Colors.red, fontSize: 15))
                  ]
                )
              ),
            ),
            Container(                                                    //Next field used to input the value of the number of vendors at that particular event 
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              padding:EdgeInsets.only( top: 0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input)=> input.isEmpty? 'Please enter a number': null,
                    onChanged: (input)=> eventNumber=int.parse(input),
                    decoration: InputDecoration(
                      labelText: 'Number of vendors',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                      
                    ),
                  )
                ],
              )
            ),
            Container(                                                          //Next field to incorporate the ask the user to upload the image of the event 
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  
                      child: TextFormField(
                        validator: (_) => logo==null || logo =='' ? 'Please enter a valid image': null,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: logo==null? 'Upload Logo Photo': 'Image Uploaded',        //Displaying user friendly messages so that the user knows whats happening each time in our app
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19
                          )
                        ),
                      )
                    
                  
                ),
                Container(                                                    //Next button for uploading the image once you click on it  
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center( child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.file_upload,
                      color: Colors.white,),
                      onPressed: () async {
                        String downloadUrl;
                        
                        File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                        String filename='${DateTime.now()}${selected.absolute}.png';
                        await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Logo'+filename).putFile(selected).onComplete;
                        downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Logo'+filename).getDownloadURL();
                        logo=downloadUrl;
                        showDialog(                 //User friendly error message when the screen has been displayed 
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                            content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                          ),
                          barrierDismissible: true,
                        );
                      },
                    ),
                  ),),
                )
              ],),
            ),
            
            Container(                              //Message to tell the user about the submission requirements of images 
              child: error1? Container() : Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.90,
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      
                      TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3 ",style: TextStyle(color: Colors.red, fontSize: 15))
                    ]
                    )),

                ),
            ),

            Container(                                        //Uploading the image of the vendor that would be displayed on the homepage 
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  child: TextFormField(
                    validator: (_) => photo==null || photo=='' ? 'Please enter a valid image': null,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: photo==null? 'Upload Cover Photo': 'Image Uploaded',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
                ),
                Container(                                                    //The photo upload button to send image
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center( child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.file_upload,
                      color: Colors.white,),
                      onPressed: () async {
                        String downloadUrl;
                        File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                        String filename='${DateTime.now()}${selected.absolute}.png';
                        await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Cover'+filename).putFile(selected).onComplete;
                        downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Cover'+filename).getDownloadURL();
                        photo=downloadUrl;
                        showDialog(                 //User friendly error message when the screen has been displayed 
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                            content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                          ),
                          barrierDismissible: true,
                        );
                      },
                    ),
                  ),),
                )
              ],),
            ),

            Container(                              //Error message to inform the user about the requirements of the images
              child: error2? Container() : Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.90,
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
                    ]
                    )),

                ),
            ),
            
              SafeArea(                                   //Displaying if there is any error when fetching from firebase
              child: err== null ? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text(err,
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15),
            ),
            Center(child: Container(
              width:60,
              height:60,
              child: Center( child: Ink(
                width:60,
                height:60,
                decoration:  ShapeDecoration(               
                  shape: CircleBorder(),
                  color: null,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]    //Gradient colour combination and filling
                  ),
                  shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_forward,
                  size: 45,
                  color: Colors.white,),
                  onPressed: () async {
                    setState(() => validate=true);
                    if(coord!=null){                      //Moving forward only when the map coordinates have been defined
                      GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);
                      String eventid; 
                      var varEvent = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:randomAlphaNumeric(10), invitecode:randomAlpha(6), location1:eventLocation, name:name, logo:logo, coverimage:photo);
                      if ( !(name==null || logo==null || photo==null || eventNumber==null) ){   //Adding values only when all validatation conditions have been fulfilled 
                        await Firestore.instance.collection("Event").add(varEvent.toJSON()).then((eid) async{
                            await Firestore.instance.collection('Event').document(eid.documentID).setData({'eventID':eid.documentID},merge: true).then((_){eventid=eid.documentID;}).catchError((e){err=e.toString();});
                        }).catchError((e){err=e.toString();});
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:eventNumber,eid:eventid,eventName:name)),);
                      }
                    }
                  },
                ),
              ),),
            ),),
          ],
          )  
        ),
      )
    ); 
  }
}
//the event menu screen loaded when clicked on the event in the data
class EventMenu extends StatefulWidget {
  final UserData userInfo;
  final String eid;
  final String eventName;
  final String inviteCode;
  EventMenu({this.eid,this.eventName,this.inviteCode, this.userInfo});
  @override 
  EventMenuState createState()=> new EventMenuState(eid:eid,eventName:eventName,inviteCode: inviteCode, userInfo: userInfo); 
}

class EventMenuState extends State<EventMenu> {
  String eid;
  String eventName;
  String inviteCode;
  String err; 
  UserData userInfo;
  EventMenuState({this.eid,this.eventName,this.inviteCode, this.userInfo});
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  var scaffoldKey=GlobalKey<ScaffoldState>();
  bool validate=false; 
                                            //getting the data from the previous screen
  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {    
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        endDrawer:  SideBarGeneral(),              //calling the sidebar drawer
        appBar: PreferredSize(              //displaying the design bar of the screen
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
                          child: Container(
                            width: MediaQuery.of(context).copyWith().size.width * 0.45,
                            child: Text(eventName,
                              style: TextStyle(
                                color: Colors.white, fontSize: 28
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                    )
                  ),
                  leading: IconButton(          //adding the back button to the app bar to navigate to previous screen
                    icon: Icon(
                      Icons.arrow_back,
                       
                      ), 
                    onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                      //Navigator.pop(context);
                    }
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(         //adding the sidebar opening buttton
                        onTap: () {
                          scaffoldKey.currentState.openEndDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                        ),
                      )
                    ),
                  ],
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
      body: Form(                 //forming the screen with vendors
        key: _formKey,
        autovalidate: validate,
        child: SingleChildScrollView(
         child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
            SafeArea(
              child: InkWell(
                onTap: (){
                },
                child: new SafeArea(
                  //padding: EdgeInsets.only(top: 130, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Invite code| ",style: TextStyle(color: Colors.grey[600], fontSize: 25)),
                      TextSpan(text: inviteCode,style: TextStyle(color: Colors.black, fontSize: 25 )),
                    ]) 
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding:EdgeInsets.only(top: 0, left: 0), 
                child: Container(
                  height: 1, 
                  width: 350, 
                  color: Colors.black,),
                ),
              
            ),

       
            SafeArea(
                child: InkWell(       //saving the data(QR code)
                  onTap: () async{
                     String basePath='/storage/emulated/0/Download/RateIt!/';
                    //Per
                    await Permission.storage.request();
                    if(await Permission.storage.isGranted){
                      if( !(await Directory(basePath).exists()) ){ 
                        await Directory(basePath).create(recursive: true);
                      }
                      if( !(await Directory(basePath+'${eventName}_$eid/').exists()) ){ 
                        await Directory(basePath+'${eventName}_$eid/').create(recursive: true);
                      }
                      //promise for loop
                      await Firestore.instance.collection('Vendor').where('eventId', isEqualTo: eid).getDocuments().then((val) async{
                        val.documents.forEach((doc) async {
                          var qr = Barcode.qrCode().toSvg('${doc.data['vendorId']}');
                          print('${doc.data['vendorId']}');
                          await File(basePath+"${eventName}_$eid/${doc.data['name']}_${doc.data['vendorId']}.svg").writeAsString(qr);
                        });
                      }).catchError((e){err=e.toString();});
                      showDialog(                 //User friendly error message when the screen has been displayed 
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                          content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                        ),
                        barrierDismissible: true,
                      );
                    } else{
                      showDialog(                 //User friendly error message when the screen has been displayed 
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Error: Please Enable Storage Permission",textAlign: TextAlign.center),
                          content: Icon(Icons.highlight_off,color:Colors.red[300],size:80),
                        ),
                        barrierDismissible: true,
                      );
                    }
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
                    padding: EdgeInsets.only(top: 15, left: 90),    //the qr code downloading function 
                    child: Text("Download QR codes",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),

            SafeArea(
                child: InkWell(
                  onTap: (){            //leading to add vendor page
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendorQty(eid: eid, eventName: eventName,)),);
                  },
                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 20), 
                  child: SafeArea(
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
                    padding: EdgeInsets.only(top: 15, left: 125), 
                    child: Text("Add Vendors",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),

                ),),),
              
            ),

            SafeArea(
                child: InkWell(
                  onTap: (){          //leading to the vendor page to view their items
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewVendor(eventName: eventName,eventID: eid,)),);  
                  },
                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 20), 
                  child: SafeArea(
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
                    padding: EdgeInsets.only(top: 15, left: 125), 
                    child: Text("Edit a Vendor",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),

                ),),),
              
            ),

            SafeArea(
                child: InkWell(
                  onTap: () async {     //getting information from the backend firestore cloud
                    
                    Event varEvent;// = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:null, invitecode:null, location1:null, name:null, logo:null, coverimage:null);
                    await Firestore.instance.collection('Event').document(eid).get().then((value){
                      Event passEvent = new Event(uid:null, eventID:null, invitecode:null, location1:value.data['location1'], name:value.data['name'], logo:value.data['logo'], coverimage:value.data['coverimage']);
                      varEvent = passEvent;
                      //varEvent.logo = value.data['userRole'];
                    }).catchError((e){err=e.toString();});
                    if(varEvent!=null){         //leading to edit event page
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> EditEvent(eid:eid,coord:LatLng(varEvent.location1.latitude, varEvent.location1.longitude) ,eventData:varEvent, )));
                    }
                  },
                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 20), 
                  child: SafeArea(
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
                    padding: EdgeInsets.only(top: 15, left: 130), 
                    child: Text("Edit Event",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),

                ),),),
                
                
                ),

                
              
            ),

            SafeArea(
              child: err== null ? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text(err,
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),
          ],),
        )  
      ),),
    );
  }
}
//the page for adding a specific number of events
class AddVendorQty extends StatefulWidget {
  final String eid;
  final String eventName;
  AddVendorQty({this.eid,this.eventName});

  @override 
  AddVendorQtyState createState()=> new AddVendorQtyState(eid:eid,eventName:eventName); 
}

class AddVendorQtyState extends State<AddVendorQty> {
  final String eid;
  int numVen;
  String eventName;
  String valSave;
  String err; 
  AddVendorQtyState({this.eid,this.eventName});

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  List<DropdownMenuItem<String>> n=[];
  void loadData(){        //drop down menu for adding a specific number of vendors
    n=[];
    n.add(new DropdownMenuItem(
      child: new Text('1'),
      value: '1')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('2'),
      value: '2')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('3'),
      value: '3')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('4'),
      value: '4')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('5'),
      value: '5')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('6'),
      value: '6')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('7'),
      value: '7')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('8'),
      value: '8')
    ); 

    n.add(new DropdownMenuItem(
      child: new Text('9'),
      value: '9')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('10'),
      value: '10')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('Custom'),
      value: 'Custom')
    ); 
  }

  bool error1=true; 
  bool validate=false; 
  int customVal; 
  String customValSave; 
  

  @override 
  Widget build(BuildContext context){
    loadData(); 
    return Scaffold(
        appBar: PreferredSize(            //displaying the design bar of the application
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
                        child: Text('Add Vendors',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Column(children: <Widget>[           //taking data for adding a specific number of vendors for a event
          SafeArea(
            child: Center(
              child: SafeArea(
                child: Container(
                padding: EdgeInsets.only(top: 40, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "How many vendors would you like to add?",style: TextStyle(color: Colors.black, fontSize: 20))
                  ],),
                ),
              ),),
            ),
          ),

          SafeArea(
            child: Container(

            padding: EdgeInsets.only(top: 50), 
            child: Center(

            child: SafeArea(
            
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [ 
                    Color(0xFFAC0D57),
                    Color(0xFFFC4A1F),
                  ]
                ),
                borderRadius: BorderRadius.circular(30),
                
              ), 

              child: SafeArea(
                child: Center(
                
                  child:DropdownButton<String>(
                    value:valSave, 
                    items:n, 
                    onChanged: (value){
                      error1=false; 
                      valSave=value; 
                      setState((){
                        
                      });
                    },
                    underline: SizedBox(), 
                    hint: Text(
                      " Vendors",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ), ),
              ), 
            ), ),
            ),
          ),

          SafeArea(               //validation that the required input has been added
              child: !(error1 && validate)? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text("Please select an option above",
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),

         
          SafeArea(               //dealing with the scenario where user wants to add a custom number of vendors from the dropdown menu
            child: valSave!="Custom"? Container() : Container(
              padding:EdgeInsets.only( top: 40, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input)=> input.isEmpty? 'Please enter a number': null,
                    onChanged: (input)=> customValSave=input,
                    decoration: InputDecoration(
                      labelText: 'Number of Vendors',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
                ],
              )
            ),
          ),
          Padding(padding: EdgeInsets.all(30)),
          SafeArea(
              child: Container(
                width:60,
                height:60,
                child: Center( child: Ink(
                  width:60,
                  height:60,
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    color: null,
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(Icons.arrow_forward,
                    size: 45,
                    color: Colors.white,),
                    onPressed: () async { //updating the vendor details in the firestore cloud
                      setState(() => validate = true);
                      if (valSave!=null && valSave!="Custom") {
                        numVen=int.parse(valSave);
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:numVen, eid:eid, eventName:eventName)),);
                      }
                      else if (valSave=="Custom" && customValSave!=null) {
                        customVal=int.parse(customValSave);
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:customVal, eid:eid, eventName:eventName)),);
                      }
                    }
                  ),
                ),),
              ),
          ),  
        ],),  
      ),),
    ); 
  }
}
//add vendor screen where the details for the vendors are taken and added
class AddVendor extends StatefulWidget {
  final int numVen;
  final String eid;
  final String eventName;
  AddVendor({this.eventName,this.numVen,this.eid});

  @override 
  AddVendorState createState()=> new AddVendorState(numVen: numVen,eid: eid,eventName: eventName ); 
}

class AddVendorState extends State<AddVendor> {
  int numVen;
  String eid;
  String eventName;
  AddVendorState({this.eventName,this.numVen,this.eid});
  List<String> name = [];
  List<String> email = new List<String>(), stallid = new List<String>(),logo = new List<String>();
  List<int> item = new List<int>();
  bool value=false;   
  bool check=false;
  List<Widget> menu=[], menu2=[];
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  void add2(i){
    menu2=List.from(menu2)..add(     
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: InkWell(
          child: new Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding: EdgeInsets.only(top: 20), 
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(                     //heading for the vendor number
                    text: "Vendor ${i+1}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                      ),
                  ),
                ]
              )
            ),
          ),
        ),
      ),
    );

    setState(() {
        
    });
  }

  void add3(i){
    menu2=List.from(menu2)..add(
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: new Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        padding:EdgeInsets.only( top: 10, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input)=> input.isEmpty? 'Please enter a name': null,
                onChanged: (input)=> name[i]= input,
                decoration: InputDecoration(
                  labelText: 'Stall Name',              //taking input for the name of the stall of the vendor
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 19
                  )
                ),
              )
            ],
          )
        ),
      ),
    );

    setState(() {
      
    });
  }

  void add4(i){
    menu2=List.from(menu2)..add(
     
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: new Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input)=> !EmailValidator.validate(input, true)? 'Please enter a valid email address' :null,
                onChanged: (input)=> email[i]= input,
                decoration: InputDecoration(
                  labelText: 'Email ID',                  //taking input of the vendor email address
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 19
                  )
                ),
              )
            ],
          ),
        ),
      ),  
    );

    setState(() {
      
    });

  }

  void add5(i){
    menu2=List.from(menu2)..add(   
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: new Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (input)=> input.isEmpty? 'Please enter a stall ID': null,
                onChanged: (input)=> stallid[i]= input,                 //taking input for the stall id of the vendor
                decoration: InputDecoration(
                  labelText: 'Stall ID',
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 19
                  )
                ),
              )
            ],
          )
        ),
      ),  
    );

    setState(() {
      
    });

  }
  TextEditingController listAccount = TextEditingController();
  void add6(i){
    menu2=List.from(menu2)..add(
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                
                  child: TextFormField(
                    controller: listAccount,
                    //enabled: false,
                    //readOnly: true,
                    validator: (_) => logo[i]==null || logo[i] =='1' ? 'Please upload a valid image': null,
                    readOnly: true,
                    decoration: InputDecoration(      //uploading a valid logo photo for the vendor
                      hintText: logo[i]==null || logo[i]=='' /*|| logo[i].length==0*/ ? 'Upload Logo Photo':'Image Uploaded',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Center( child: Ink(
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.file_upload,
                    color: Colors.white,),
                    onPressed: () async{    //uploading and extracting the URL of the picture from the firestore cloud
                      String downloadUrl;
                      File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                      String filename='${DateTime.now()}${selected.absolute}.png';
                      await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('VendorData/Logo'+filename).putFile(selected).onComplete;
                      downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('VendorData/Logo'+filename).getDownloadURL();
                      //downloadUrl='url';
                      setState(() {
                        logo[i]=downloadUrl;
                      });
                      logo[i]=downloadUrl;
                      print(logo[i]);
                      showDialog(                 //User friendly error message when the screen has been displayed 
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                          content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                        ),
                        barrierDismissible: true,
                      );
                    },
                  ),
                ),),
              )
            ],),
          ),
    );

    setState(() {
      
    });

  }


   void add8(i){
    menu2=List.from(menu2)..add(
     
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
          padding: EdgeInsets.only(top: 0, left: 20), 
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              //Displaying a message for user friendly code so user knows the size of image 
              TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
            ]
            )
          ),
        ),
      ),
    );

    setState(() {
      
    });

  }

   void add9(i){
    menu2=List.from(menu2)..add(
     
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: new Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (input)=> input.isEmpty? 'Please enter a number': null,
                onChanged: (input)=> item[i]= int.parse(input),     //taking input for the number of vendor menu items
                decoration: InputDecoration(
                  labelText: 'Number of menu items', 
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 19
                  )
                ),
              )
            ],
          )
        ),
      ),
    );

    setState(() {
      
    });

  }
  //testing that the data has been added to the relevant fields
  bool validate=false; 
  bool error1=false; 

  String err;
  @override 
  Widget build(BuildContext context){
    //building the widget for collecting the data regarding vendor details
    if (!check && numVen>0){
      Padding(padding: EdgeInsets.only(top: 15));
      for (var i=0 ; i<numVen ; i++){
        name.add('');
        email.add('');
        stallid.add('');
        logo.add('');
        item.add(0);
        Padding(padding: EdgeInsets.only(top: 10));
        add2(i);
        add3(i);
        add4(i); 
        add5(i); 
        add6(i); 
        add8(i); 
        add9(i); 
      }
      check=true; 
    }
   
    
    
    return Scaffold(
     
      resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppBar(           //displaying the design bar of the application
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.0, left: 10),
                        child: Text('Add Vendors',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
      body: Form(             //getting the details for the vendors using the functions defined above
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Column(children: <Widget>[  
          Center(
            child: Column(
            children: menu2),
          ),

          SafeArea(
            child: err== null ? Container() : Container(
              
              padding:EdgeInsets.only( top: 5), 
              child: Column(
                children: <Widget>[
                  
                  Container(
                    alignment: Alignment(-0.8,-0.9),
                      child: Text(err,
                      style: TextStyle(color: Colors.red)
                      ),
                  ),
                ],
              )                        
            ),
          ),

          Padding(
            padding: EdgeInsets.all(15),
          ),


          Center(child: Container(
            width:60,
            height:60,
            child: Center( child: Ink(
              width:60,
              height:60,
              decoration:  ShapeDecoration(
                shape: CircleBorder(),
                color: null,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                ),
                shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
              ),
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(Icons.arrow_forward,
                size: 45,
                color: Colors.white,),
                onPressed: () async {
                  setState(() => validate=true);      //validation whether the data has been added to the required fields
                  bool check =true;
                  List<String> venId = List<String>();
                  for(var i=0; i<numVen; i++){
                    if(name[i]=='' || email[i]=='' || stallid[i]=='' || item[i]==0|| !EmailValidator.validate(email[i], true)){
                      check=false;
                    }
                  }
                  if (check){
                    
                    for (var i=0; i<numVen; i++){   //uploading the vendor data to the firestore
                        await Firestore.instance.collection("Vendor").add({'aggregateRating' : 0.0, 'numRatings':0.0,'email' : email[i], 'eventId' : eid, 'name' : name[i], 'stallNo' : int.parse(stallid[i]), 'logo':logo[i] }).then((vid) async{
                            await Firestore.instance.collection('Vendor').document(vid.documentID).setData({'qrCode' : vid.documentID, 'vendorId':vid.documentID,}, merge: true).then((_){venId.add(vid.documentID);}).catchError((e){err=e.toString();});
                        }).catchError((e){err=e.toString();});
                    }
                    //navigating to the add menu item screen
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> AddMenu(eid:eid,vid: venId, numVen: item,eventName:eventName)),);   //Modify here to upload Event Data and then move on
                  }
                },
              ),
            ),),
          ),),
      
         Padding(
            padding: EdgeInsets.all(15),
          ),
          
        ],
        )  
      ),),

      
    ); 
  }
}

//making the add menu screen where details regarding menu items for each vendor will be added
class AddMenu extends StatefulWidget {
  final String eid;
  final List<String> vid;
  final List<int> numVen;
  final String eventName;
  AddMenu({this.eid,this.numVen,this.vid,this.eventName});

  @override 
  AddMenuState createState()=> new AddMenuState(vid:vid, numVen:numVen, eid:eid, eventName:eventName); 
}

class AddMenuState extends State<AddMenu> {
  String eid;
  String eventName;
  List<String> vid;
  bool validate=false; 
  List<int> numVen;
  AddMenuState({this.eid,this.numVen,this.vid,this.eventName});
  List<List<String>> itemname = new List<List<String>>(),mlogo = new List<List<String>>();
  //List<String> itemcoll = new List<String>();
  bool value=false;
  bool check=false;
  List<Widget> menu=[], menu2=[]; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  String err; 


  void addvalue(i,j){
    menu2=List.from(menu2)..add(
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              //keyboardType: TextInputType.number,
              validator: (input)=> input.isEmpty? 'Please enter menu item': null,     //fensuring name for the menu item is added 
              onChanged: (input)=> itemname[i][j]=input,    //input for the menu item
              decoration: InputDecoration(
                labelText: 'Menu Item ${j+1}',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            ),
          ],
        )
      ),
    );
    setState(() {
        
    });
  }
  

  void addvalue2(i,j){
    menu2=List.from(menu2)..add(
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: Row(children: <Widget>[
          Container(      //getting the image of the relevant menu item
            width: MediaQuery.of(context).copyWith().size.width * 0.75,
            padding:EdgeInsets.only( top: 5, left: 20),
            child: TextFormField(
              validator: (_) => mlogo[i][j]==null || mlogo[i][j] =='' ? 'Please upload a valid image': null,
              readOnly: true,
              decoration: InputDecoration(
                hintText: mlogo[i][j]==null || mlogo[i][j]=='' ? 'Upload Logo Photo':'Image Uploaded',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            )
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.10,
            child: Center( child: Ink(
              decoration:  ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                ),
                shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
              ),
              child: IconButton(
                icon: Icon(Icons.file_upload,
                color: Colors.white,),
                onPressed: () async{      //uploading image and fetching the download URL link for storage in firebase
                  String downloadUrl;
                  File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                  String filename='${DateTime.now()}${selected.absolute}.png';
                  await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).putFile(selected).onComplete;
                  downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).getDownloadURL();
                  mlogo[i][j]=downloadUrl;
                  showDialog(                 //User friendly error message when the screen has been displayed 
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                      content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                    ),
                    barrierDismissible: true,
                  );                 
                },
              ),
            ),),
          )
        ],),
      ),
    );
    setState(() {
    });
  }
  
  void add2(i){
    menu2=List.from(menu2)..add(
      Container(
        child: InkWell(
        child: new Container(
          child: Align(
            alignment: Alignment(-0.8,-1.0),
            child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: "Vendor ${i+1}",style: TextStyle(color: Colors.black, fontSize: 22))
            ]
            )),
          ),),
        ),
      ),
    );

      setState(() {
        
      });

  }
 
 
var scaffoldKey=GlobalKey<ScaffoldState>();
  @override 
  Widget build(BuildContext context){
    if (!check)
    {
      for (var i=0; i<numVen.length; i++)
      {
        add2(i); 
        itemname.add([]);
        mlogo.add([]);
        for (var j=0; j<numVen[i]; j++){
          itemname[i].add('');
          mlogo[i].add('');
          addvalue(i,j); 
          addvalue2(i,j);
        }
      }
      check=true; 
    }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        appBar: PreferredSize(            //displaying the designbar of the application
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
                        child: Text('Add Menu',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
      body: Form(             //widget for getting menu items using the above functions
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Center( 
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: menu2
                ),
              ), 
              SafeArea(
                child: err== null ? Container() : Container(
                  
                  padding:EdgeInsets.only( top: 5), 
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        alignment: Alignment(-0.8,-0.9),
                          child: Text(err,
                          style: TextStyle(color: Colors.red)
                          ),
                      ),
                    ],
                  )                        
                ),
              ),
              Padding(padding: EdgeInsets.all(30)),
              Center(
                child: SafeArea(
                  child: Container(
                    width:60,
                    height:60,
                    child: Center( child: Ink(
                      width:60,
                      height:60,
                      decoration:  ShapeDecoration(
                        shape: CircleBorder(),
                        color: null,
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                        ),
                        shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                      ),
                      child: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.arrow_forward,
                        size: 45,
                        color: Colors.white,),
                        onPressed: () async { //updating the vendor details in the firestore cloud
                          setState(() => validate=true);
                          bool checkNext = true;
                          //add eid from previous screen here to pass to QR to Event menu 
                          for (var i=0; i<numVen.length; i++){
                            for (var j=0; j<numVen[i]; j++){
                              if(itemname[i][j]=='' ){
                                checkNext=false;
                              }
                            }
                          }
                          if (checkNext){
                            for (var i=0; i<numVen.length; i++){    //updating the data for each vendor
                              for (var j=0; j<numVen[i]; j++){
                                await Firestore.instance.collection("item").add({'aggregateRating':0.0,'numRatings':0.0,'logo':mlogo[i][j],'name':itemname[i][j],'vendorId':vid[i]}).then((vid) async{
                                    await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){}).catchError((e){err=e.toString();});//venId.add(vid.documentID);});
                                }).catchError((e){err=e.toString();});
                              }
                            }
                            //navigating to the QR image page
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> QRselection(eid:eid,eventName:eventName)),);   //Modify here to upload Event Data and then move on
                          }
                        }
                      ),
                    ),),
                  ),
                ),
              ),
            ],
          )
        )  
      ),),
    ); 
  }
}
//updated add menu class for modified usage
class AddMenu2 extends StatefulWidget {
  final String eid;
  final List<String> vid;
  final List<int> numVen;
  final String eventName;
  AddMenu2({this.eid,this.numVen,this.vid,this.eventName});

  @override 
  AddMenu2State createState()=> new AddMenu2State(vid:vid, numVen:numVen, eid:eid, eventName:eventName); 
}

class AddMenu2State extends State<AddMenu2> {
  String eid;
  String eventName;
  List<String> vid;
  List<int> numVen;
  bool validate=false; 
  AddMenu2State({this.eid,this.numVen,this.vid,this.eventName});
  List<List<String>> itemname = new List<List<String>>(),mlogo = new List<List<String>>();
  bool value=false;
  bool check=false;

  List<Widget> menu=[], menu2=[]; 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 


  void addvalue(i,j){
    menu2=List.from(menu2)..add(
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input)=> input.isEmpty? 'Please enter menu item': null,     //validating whether name has been entered or not
              onChanged: (input)=> itemname[i][j]=input,          //entering the menu item
              decoration: InputDecoration(
                labelText: 'Menu Item ${j+1}',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            ),
          ],
        )
      ),
    );
    setState(() {
        
    });

  }

  void addvalue2(i,j){    //function for getting the menu item image
    menu2=List.from(menu2)..add(
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: Row(children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.75,
            padding:EdgeInsets.only( top: 5, left: 20),
            child: TextFormField(
              validator: (_) => mlogo[i][j]==null || mlogo[i][j] =='' ? 'Please upload a valid image': null,
              readOnly: true,
              decoration: InputDecoration(
                hintText: mlogo[i][j]==null || mlogo[i][j]=='' ? 'Upload Logo Photo':'Image Uploaded',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            )
          ),

          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.10,
            child: Center( child: Ink(
              decoration:  ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                ),
                shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
              ),
              child: IconButton(
                icon: Icon(Icons.file_upload,
                color: Colors.white,),
                onPressed: () async {       //uploading the image and fetching its download URL for later use
                  String downloadUrl;
                  File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                  String filename='${DateTime.now()}${selected.absolute}.png';
                  await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).putFile(selected).onComplete;
                  downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).getDownloadURL();
                  mlogo[i][j]=downloadUrl;
                  print(mlogo[i][j]);
                  showDialog(                 //User friendly error message when the screen has been displayed 
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                      content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                    ),
                    barrierDismissible: true,
                  );
                },
              ),
            ),),
          )
        ],),
      ),
    );
    setState(() {
    });
  }
  
  void add2(i){
    menu2=List.from(menu2)..add(
      Container(
        child: InkWell(
        child: new Container(
          child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: "Vendor ${i+1}",style: TextStyle(color: Colors.black, fontSize: 22))
          ]
          )),
        ),
        ),
      ),
    );

      setState(() {
        
      });

  }
  String err;
 
 
var scaffoldKey=GlobalKey<ScaffoldState>();
  @override 
  Widget build(BuildContext context){
    if (!check)
    {
      for (var i=0; i<numVen.length; i++)
      {
        add2(i); 
        itemname.add([]);
        mlogo.add([]);
        for (var j=0; j<numVen[i]; j++){
          itemname[i].add('');
          mlogo[i].add('');
          addvalue(i,j); 
          addvalue2(i,j);
        }
      }
      check=true; 
    }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        appBar: PreferredSize(          //displaying the design bar of the application
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
                        child: Text('Add Menu',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,    
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
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
            clipper: ClipShape(),
          )
        ),
      body: Form(         //making the display for adding menu items using above defined functions
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Center( 
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: menu2
                ),
              ), 
              SafeArea(
                child: err== null ? Container() : Container(
                  
                  padding:EdgeInsets.only( top: 5), 
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        alignment: Alignment(-0.8,-0.9),
                          child: Text(err,
                          style: TextStyle(color: Colors.red)
                          ),
                      ),
                    ],
                  )                        
                ),
              ),
              Padding(padding: EdgeInsets.all(30)),
              Center(
                child: SafeArea(
                  child: Container(
                    width:60,
                    height:60,
                    child: Center( child: Ink(
                      width:60,
                      height:60,
                      decoration:  ShapeDecoration(
                        shape: CircleBorder(),
                        color: null,
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                        ),
                        shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                      ),
                      child: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.arrow_forward,
                        size: 45,
                        color: Colors.white,),
                        onPressed: () async { //updating the vendor details in the firestore cloud
                          setState(() => validate=true);
                          bool checkNext = true;
                          //add eid from previous screen here to pass to QR to Event menu 
                          for (var i=0; i<numVen.length; i++){
                            for (var j=0; j<numVen[i]; j++){
                              if(itemname[i][j]=='' ){
                                checkNext=false;
                              }
                            }
                          }
                          if (checkNext){
                            for (var i=0; i<numVen.length; i++){      //uploading the data regarding the menu items to the firestore cloud
                              for (var j=0; j<numVen[i]; j++){
                                  await Firestore.instance.collection("item").add({'aggregateRating':0.0,'numRatings':0.0,'logo':mlogo[i][j],'name':itemname[i][j],'vendorId':vid[i]}).then((vid) async{
                                      await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){}).catchError((e){err=e.toString();});//venId.add(vid.documentID);});
                                  }).catchError((e){err=e.toString();});
                              }
                            }
                            Navigator.pop(context);
                          }
                        }
                      ),
                    ),),
                  ),
                ),
              ),
            ],
          )
        )  
      ),),
    ); 
  }
}

//the screen for editting the vendor details
class EditVendor extends StatefulWidget {
  final UserData myUser;
  final Vendor vendorData;
  final String eventName;
  EditVendor({this.myUser, this.eventName,this.vendorData});
  @override 
  EditVendorState createState()=> new EditVendorState(vendorData: vendorData,eventName: eventName); 
}

class EditVendorState extends State<EditVendor> {
  String name="",email="",logo="";
 
  int stallid;
  int item=0;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 
  Vendor vendorData;
  String eventName;
  EditVendorState({this.eventName,this.vendorData});
  bool check=false; 
  bool validate=false; 
  String err;



  List<Widget> menu=[], menu2=[];   
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  //getting the required data into the screen
  @override
  void initState() {
    super.initState();
    if(eventName==null)
      myUserInfo = widget.myUser;
    name= vendorData.name;
    logo= vendorData.logo;
    email = vendorData.email;
    stallid= vendorData.stallNo;
    dcontroller.text= vendorData.name;
    dcontroller2.text= vendorData.email;
    dcontroller3.text= vendorData.logo;
    dcontroller4.text= vendorData.stallNo.toString();
  }

  @override 
  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(      //displaying the app bar of the application
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
                      child: Text('Edit Vendors',style: TextStyle(color: Colors.white, fontSize: 28 ))
                    ),
                  )
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,   
                  ), 
                  onPressed: (){
                    Navigator.pop(context);
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
          clipper: ClipShape(),
        )
      ),
      body: Form(
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(      //displaying current details 
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: InkWell(
              child: new Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Vendor Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                        ),
                      ),
                    ]
                  )
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: dcontroller,
                  validator: (input)=> input.isEmpty? 'Please enter vendor name': null, //validating whether input has been given
                  onChanged: (input)=> name=input,  //getting vendor name from the user
                  decoration: InputDecoration(
                    hintText: 'Stall Name',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller.clear());
                        }),
                      },
                    ),
                  ),
                )
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(//updating the email address of the vendor
                  controller: dcontroller2,
                  validator: (input)=> !EmailValidator.validate(input, true)? 'Please enter a valid email address' :null,
                  onChanged: (input)=> email=input,
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller2.clear());
                        }),
                      },
                    ),
                  ),
                )
              ],
            )
          ),
          Container(        //updating the stall id of the vendor
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: dcontroller4,
                  validator: (input)=> input.isEmpty? 'Please enter stall id': null,
                  onChanged: (input)=> stallid=int.parse(input),
                  decoration: InputDecoration(
                    hintText: 'Stall ID',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller4.clear());
                        }),
                      },
                    ),
                  ),
                )
              ],
            )
          ),

          Container(    //updating the imafe of the vendor
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.75,
                padding:EdgeInsets.only( top: 5, left: 20),
                child: TextFormField(
                  readOnly: true,
                  validator: (_) => logo==null || logo =='' ? 'Please upload a valid image': null,
                  decoration: InputDecoration(
                    hintText: logo==null || logo =='' ? 'Upload Logo Photo':'Image Uploaded',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    ),),
                )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Center( child: Ink(
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.file_upload,
                    color: Colors.white,),
                    onPressed: () async {   //uploading the new image and fetching its download link for storage
                      String downloadUrl;
                      File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                      String filename='${DateTime.now()}${selected.absolute}.png';
                      await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('VendorData/Logo'+filename).putFile(selected).onComplete;
                      downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('VendorData/Logo'+filename).getDownloadURL();
                      logo=downloadUrl;
                      showDialog(                 //User friendly error message when the screen has been displayed 
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                          content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                        ),
                        barrierDismissible: true,
                      );
                    },
                  ),
                ),),
              )
            ],),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding: EdgeInsets.only(top: 0, left: 20), 
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3 ",style: TextStyle(color: Colors.red, fontSize: 15))
              ],),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Container(    //updating the items of the vendors
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding: EdgeInsets.only(top: 0, left: 20), 
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "Enter a value to add more Items:",style: TextStyle(color: Colors.black,fontSize: 20))
              ],),
            ),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.75,
                padding:EdgeInsets.only( top: 5, left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (input) {
                    item=int.parse(input);
                  },
                  decoration: InputDecoration(
                    labelText: 'Number of items',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Center( child: Ink(
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add,
                    color: Colors.white,),
                    onPressed: () {
                      //leading to update menu item screen for adding more items
                      if (item>0){//connect item here
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> AddMenu2(eid:vendorData.eventId,numVen:[item],vid: [vendorData.vendorId],eventName: eventName,)),);
                      }
                    },
                  ),
                ),),
              )
            ],),
          ),

          SafeArea(
            child: err== null ? Container() : Container(
              
              padding:EdgeInsets.only( top: 5), 
              child: Column(
                children: <Widget>[
                  
                  Container(
                    alignment: Alignment(-0.8,-0.9),
                      child: Text(err,
                      style: TextStyle(color: Colors.red)
                      ),
                  ),
                ],
              )                        
            ),
          ),

          Padding(
            padding: EdgeInsets.all(15),
          ),
          Center(
            child: Container(
              width:60,
              height:60,
              child: Center( child: Ink(
                width:60,
                height:60,
                decoration:  ShapeDecoration(
                  shape: CircleBorder(),
                  color: null,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                  ),
                  shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_forward,
                  size: 45,
                  color: Colors.white,),
                  onPressed: () async { //updating the vendor details in the firestore cloud
                    setState(() => validate=true);
                    if ( !(name=="" || email==""|| stallid==null|| logo=="" || name==null || email==null || logo==null ) ){
                      await Firestore.instance.collection('Vendor').document(vendorData.vendorId).setData({'name':name, 'logo':logo,'email':email,'stallNo':stallid},merge: true).then((_) async {
                        await Firestore.instance.collection('ratedVendor').where('vendorId', isEqualTo: vendorData.vendorId).getDocuments().then((val) async{
                            val.documents.forEach((doc) async {
                              await Firestore.instance.collection('ratedVendor').document(doc.documentID).setData({'name':name, 'logo':logo,'email':email,'stallNo':stallid},merge: true).catchError((e){err=e.toString();});
                            });
                        }).catchError((e){err=e.toString();});
                      }).catchError((e){err=e.toString();});
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewMenu(eventID:vendorData.eventId, eventName:eventName, vendorID:vendorData.vendorId,)),);
                    } else {
                      print('error'+logo);
                    }
                  }
                ),
              ),),
            ),
          ),
        ],
        )  
      ),),
    ); 
  }
}


// creating the edit event screen
class EditEvent extends StatefulWidget {
  final Event eventData;
  final LatLng coord;
  final String eid;
  EditEvent({this.eid,this.coord,this.eventData});
  @override 
  EditEventState createState()=> new EditEventState(eid:eid,coord:coord,eventData: eventData); 
}

class EditEventState extends State<EditEvent> {
  Event eventData;
  LatLng coord;
  String eid;
  String savedName="", savedLogo="", savedCover="";
  GeoPoint savedLocation;
  EditEventState({this.eid,this.coord,this.eventData});
  bool validate=false; 

  String name, add, vendor, image, pic;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 

  
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  List<Widget> menu=[], menu2=[]; 
  int count=1; 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  String err;

  void getCoordinates() async {
    final updatedcoord = await Navigator.push(
      context,        //changing the coordinates
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => Maps()),
    );
    coord=updatedcoord;
  }
  @override
  void initState() {
    super.initState();
    savedName=eventData.name;
    savedLocation=GeoPoint(coord.latitude, coord.longitude);
    savedLogo=eventData.logo;
    savedCover=eventData.coverimage;
    dcontroller.text=eventData.name;
    dcontroller3.text=eventData.logo;
    dcontroller4.text=eventData.coverimage;
  }
  @override 
  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: ClipPath(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              AppBar(                 //displaying the designbar of the application
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0, left: 10),
                      child: Text('Edit Event',style: TextStyle(color: Colors.white, fontSize: 28 ))
                      ),
                  )
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ), 
                  onPressed: (){
                    Navigator.pop(context);
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
          clipper: ClipShape(),
        )
      ),
      body: Form(
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              padding:EdgeInsets.only( top: 10, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(                  //changing the name of the event
                    controller: dcontroller,
                    validator: (input)=> input.isEmpty? 'Please enter event name': null,
                    onChanged: (input)=> savedName=input,
                    decoration: InputDecoration(
                      hintText: 'Enter Event Name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: ()=>{
                          setState((){
                            WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller.clear());
                          }),
                        },
                      ),
                    ),
                  )
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(                      //changing the location of the event
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                      child: TextFormField(
                        validator: (_) => coord==null ? 'Please Mark a Location': null,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: coord==null?'Location of Event':'(${coord.latitude},${coord.longitude})',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19
                          )
                        ),
                      )
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center( child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add_location,
                      color: Colors.white,),
                      onPressed: () {
                        getCoordinates();
                      },
                    ),
                  ),),
                )
              ],),
            ),
            Container(            //changing the radius of the event
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              padding: EdgeInsets.only(top: 0, left: 20), 
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "*Only users within 20 kilometres from location coordinates will be able to rate",style: TextStyle(color: Colors.red, fontSize: 15))
                  ]
                )
              ),
            ),
            Container(        //changing the picture of the event
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  
                      child: TextFormField(
                        validator: (_) => savedLogo==null || savedLogo=='' ? 'Please upload a valid image': null,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: coord==null?'Upload Logo Photo':'Image Uploaded',
                        ),
                      )
                    
                  
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center( child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.file_upload,
                      color: Colors.white,),
                      onPressed: () async{          //updating the changed information to db
                        String downloadUrl;
                        String filename='${DateTime.now()}${eventData.name}.png';
                        File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                        await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Logo'+filename).putFile(selected).onComplete;
                        downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Logo'+filename).getDownloadURL();
                        savedLogo=downloadUrl;
                        showDialog(                 //User friendly error message when the screen has been displayed 
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                            content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                          ),
                          barrierDismissible: true,
                        );
                      },
                    ),
                  ),),
                )
              ],),
            ),
            
            Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.90,
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      
                      TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3 ",style: TextStyle(color: Colors.red, fontSize: 15))
                    ]
                    )),

            ),

            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  child: TextFormField( 
                    validator: (_) => savedCover==null || savedCover=='' ? 'Please upload a valid image': null,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: coord==null?'Upload Cover Photo':'Image Uploaded',
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Center( child: Ink(
                    decoration:  ShapeDecoration(
                      shape: CircleBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                      ),
                      shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.file_upload,
                      color: Colors.white,),
                      onPressed: () async {     //uploading the changed info to database
                        String downloadUrl;
                        String filename='${DateTime.now()}${eventData.name}.png';
                        File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                        await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Cover'+filename).putFile(selected).onComplete;
                        downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('EventData/Cover'+filename).getDownloadURL();
                        savedCover=downloadUrl;
                        showDialog(                 //User friendly error message when the screen has been displayed 
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                            content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                          ),
                          barrierDismissible: true,
                        );
                      },
                    ),
                  ),),
                )
              ],),
            ),
            
            Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.90,
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
                    ]
                    )),

            ),

            SafeArea(
              child: err== null ? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text(err,
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15),
            ),
            Center(
              child: Container(
                width:60,
                height:60,
                child: Center( child: Ink(
                  width:60,
                  height:60,
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    color: null,
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(          //adding the forward button to navigate ahead
                    alignment: Alignment.center,
                    icon: Icon(Icons.arrow_forward,
                    size: 45,
                    color: Colors.white,),
                    onPressed: () async {
                      setState(() => validate=true);
                      if(coord!=null){
                        if ( !(savedName==null || savedLogo==null || savedCover==null) ){     //getting data from the database
                          GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);
                          await Firestore.instance.collection('Event').document(eid).setData({'name':savedName,'location1':eventLocation,'logo':savedLogo,'coverimage':savedCover},merge: true).catchError((e){err=e.toString();});
                          Navigator.pop(context);
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:savedName,inviteCode: eventData.invitecode,)),);
                        }
                      }
                    }
                  ),
                ),),
              ),
            ),
          ],
        ),  
      ),
    ),); 
  }
}
//Qr generation of the event
class QRselection extends StatefulWidget {
  final String eid;
  final String eventName;
  QRselection({this.eid,this.eventName});

  @override
  QRselectionState createState() => new QRselectionState(eid:eid,eventName:eventName);
}

class QRselectionState extends State<QRselection> {
  String eid,eventName;
  String err; 
  QRselectionState({this.eid,this.eventName});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[

                AppBar(           //displaying the design bar of the application
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.0, left: 10),
                        child: Text('QR Code',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: 
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: 
                          Container(
                            child: GestureDetector(
                              onTap: ()async{     //getting the data from the database
                                String inviteCode,eventNme;
                                await Firestore.instance.collection('Event').document(eid).get().then((val) async{
                                  inviteCode=val.data['invitecode'];
                                  eventNme=val.data['name'];
                                }).catchError((e){err=e.toString();});                                
                              String basePath='/storage/emulated/0/Download/RateIt!/';
                              await Permission.storage.request();
                              if(await Permission.storage.isGranted){
                                if( !(await Directory(basePath).exists()) ){ 
                                  await Directory(basePath).create(recursive: true);
                                }
                                if( !(await Directory(basePath+'${eventNme}_$eid/').exists()) ){ 
                                  await Directory(basePath+'${eventNme}_$eid/').create(recursive: true);
                                }
                                //promise for loop
                                await Firestore.instance.collection('Vendor').where('eventId', isEqualTo: eid).getDocuments().then((val) async{
                                  val.documents.forEach((doc) async {
                                    var qr = Barcode.qrCode().toSvg('${doc.data['vendorId']}');
                                    await File(basePath+"${eventNme}_$eid/${doc.data['name']}_${doc.data['vendorId']}.svg").writeAsString(qr);
                                  });
                                }).catchError((e){err=e.toString();});
                                await showDialog(                 //User friendly error message when the screen has been displayed 
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                                    content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                                  ),
                                  barrierDismissible: true,
                                );
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventNme,inviteCode:inviteCode)),);
                              } else{
                                showDialog(                 //User friendly error message when the screen has been displayed 
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Error: Please Enable Storage Permission",textAlign: TextAlign.center),
                                    content: Icon(Icons.highlight_off,color:Colors.red[300],size:80),
                                  ),
                                  barrierDismissible: true,
                                );
                              }
                              },
                              child: Container(
                                width: 250.0,
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
                                  boxShadow: const[BoxShadow(blurRadius: 10),],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.all(12.0),
                                child:Center(     //download QR codes to the gallery
                                  child: 
                                    Text('Download QR Codes',
                                      style: TextStyle(
                                        color: Colors.white, 
                                        fontSize: 22
                                      ) 
                                    ),
                                ),
                              ),
                            )
                          ),
                      ),

                      SafeArea(
                      child: err== null ? Container() : Container(
                        
                        padding:EdgeInsets.only( top: 5), 
                        child: Column(
                          children: <Widget>[
                            
                            Container(
                              alignment: Alignment(-0.8,-0.9),
                                child: Text(err,
                                style: TextStyle(color: Colors.red)
                                ),
                            ),
                          ],
                        )                        
                      ),
                    ),
                    ],
                  ),
              ),
              SafeArea(
                child: err== null ? Container() : Container(
                  padding:EdgeInsets.only( top: 5), 
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        alignment: Alignment(-0.8,-0.9),
                          child: Text(err,
                          style: TextStyle(color: Colors.red)
                          ),
                      ),
                    ],
                  )                        
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
//adding to maps api to the application for the location info
class Maps extends StatefulWidget {

  @override
  MapsFunc createState() => MapsFunc();
}


class MapsFunc extends State<Maps> {
  LatLng coord;
  Completer<GoogleMapController> _controller = Completer();
  Marker marker=Marker(
    markerId: MarkerId("1"),
    draggable: true
  ); //storing position coordinates in the variable
  Set<Marker> markerSet={};
  var scaffoldKey=GlobalKey<ScaffoldState>();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppBar(     //displaying the design bar of the application
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40.0, left: 10),
                        child: Text('Location',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,    
                      ), 
                    onPressed: (){
                      Navigator.pop(context, coord);
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
            clipper: ClipShape(),
          )
        ),

        body:     
        GoogleMap(          //using the google map api
          onTap: (LatLng coordinates){          //This gesture function will place a marker whereever the user taps on the map
                final Marker marker1 = Marker(      
                  markerId: MarkerId('1'),
                  draggable: true,
                  position: coordinates,
                );
                setState(() {
                  markerSet.clear();
                  markerSet.add(marker1);
                  marker=marker1;
                  coord=coordinates;        //coordinates (latitude and longitude) are saved in coord which is LatLng variable
                });
          },
          markers: markerSet,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(    //Initial Position of Google Maps
            target: LatLng(30, 68),
            zoom: 5,
          ),
          mapType: MapType.hybrid,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          myLocationEnabled: true,          
        ),
      ),
    );
  }
}


//creating the view vendor screen of the application
class ViewVendor extends StatefulWidget {
  ViewVendor({this.eventName, this.eventID});
  final String eventName;
  final String eventID;

  @override
  State<StatefulWidget> createState() {
    return ViewVendorState(eventName: eventName,eventID: eventID);
  }
}

class ViewVendorState extends State<ViewVendor> {
  ViewVendorState({this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  String result;
  UserData userInfo;
  
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Vendor>>.value(
      value: FirestoreService().getVendorInfo(eventID),
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(          //displaying the design bar of the application
            preferredSize: Size.fromHeight(150.0),
            child: ClipPath(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,    
                        ), 
                      onPressed: (){
                        Navigator.pop(context);
                      }
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(         //adding the sidebar opening buttton
                          onTap: () {
                            scaffoldKey.currentState.openEndDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                          ),
                        )
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 40.0, left: 10),
                          child: Container(
                            width: MediaQuery.of(context).copyWith().size.width * 0.45,
                            child: Text('${widget.eventName}',
                              style: TextStyle(
                                color: Colors.white, fontSize: 28
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
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
                          ]),
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
              clipper: Clipshape(),
            )),
        endDrawer: SideBarGeneral(),
        body:
          VendorsListHostit(eventName: eventName,),   //using a widget previously made to display the design and functionality of the screen
      ),
    );
  }
}

//creating the view menu display of the screens
class ViewMenu extends StatefulWidget {
  ViewMenu({this.vendorID,this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  final String vendorID;

  @override
  State<StatefulWidget> createState() {
    return ViewMenuState(eventName: eventName,eventID: eventID,vendorID: vendorID,);
  }
}

class ViewMenuState extends State<ViewMenu> {
  ViewMenuState({this.vendorID,this.eventName, this.eventID});
  String eventName;
  String eventID;
  String vendorID;
  String result;
  UserData userInfo;
  
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: FirestoreService().getItemInfo(vendorID),
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: SideBarGeneral(),      //calling the sidebar widget to display the sidebar drawer
        appBar: PreferredSize(      //displaying the design bar of the application
            preferredSize: Size.fromHeight(150.0),
            child: ClipPath(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,    
                        ), 
                      onPressed: (){
                        Navigator.pop(context);
                      }
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(         //adding the sidebar opening buttton
                          onTap: () {
                            scaffoldKey.currentState.openEndDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                          ),
                        )
                      ),
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 40.0, left: 10),
                              child: Text('Menu Items',
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
        body:Column( 
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(child:ListItemHostIt(eventName: eventName,eventID: eventID,)),
          ]
        ),
      ),
    );
  }
}
//creating the edit item screen
class EditMenu extends StatefulWidget {
  final Item itemData;
  EditMenu({this.itemData});
  @override 
  EditMenuState createState()=> new EditMenuState(itemData: itemData,); 
}

class EditMenuState extends State<EditMenu> {
  String name,logo,err;
  final dcontroller=new TextEditingController();
  final dcontroller3=new TextEditingController();
  Item itemData;
  EditMenuState({this.itemData});
  bool value=false;
  bool check=false;
  List<Widget> menu=[], menu2=[]; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  bool validate=false; 

  @override
  void initState() {
    super.initState();
    name= itemData.name;
    logo= itemData.logo;
    dcontroller.text= itemData.name;
    dcontroller3.text= itemData.logo;
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(    //creating the designbar of the application
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
                      child: Text('Edit Item',style: TextStyle(color: Colors.white, fontSize: 28 ))
                    ),
                  )
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ), 
                  onPressed: (){
                    Navigator.pop(context);
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
          clipper: ClipShape(),
        )
      ),
      body: Form(
        key: _formKey,
        autovalidate: validate, 
        child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: InkWell(
              child: new Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
                
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Item Details",     //displaying the item detail heading
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                          ),
                      ),
                    ]
                  )
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(      //allowing the item information to be changed
                  controller: dcontroller,
                  validator: (input)=> input.isEmpty? 'Please enter item name': null,
                  onChanged: (input)=> name=input,
                  decoration: InputDecoration(
                    hintText: 'Item Name',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller.clear());
                        }),
                      },
                    ),
                  ),
                )
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.75,
                padding:EdgeInsets.only( top: 5, left: 20),
                  child: TextFormField(   //changing the logo of the item

                    validator: (_) => logo==null || logo =='' ? 'Please upload a valid image': null,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: logo==null || logo =='' ? 'Upload Logo Photo':'Image Uploaded',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Center( child: Ink(
                  decoration:  ShapeDecoration(
                    shape: CircleBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                    ),
                    shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.file_upload,
                    color: Colors.white,),
                    onPressed: () async {   //uploading the new picture to db and fetching download link for later use
                      String downloadUrl;
                      File selected = await ImagePicker.pickImage(source:ImageSource.gallery);                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.                                                                  //application waits while user chooses an image to upload. image is later uploaded to firestore storage and firestore image link is fetched and saved in logo variable.
                      String filename='${DateTime.now()}${selected.absolute}.png';
                      await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).putFile(selected).onComplete;   
                      downloadUrl = await FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('ItemData/Logo'+filename).getDownloadURL(); 
                      logo=downloadUrl;
                      showDialog(                 //User friendly error message when the screen has been displayed 
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Success",textAlign: TextAlign.center,style: TextStyle(fontSize:28),),
                          content: Icon(Icons.check_circle_outline,color:Colors.green[300],size:80),
                        ),
                        barrierDismissible: true,
                      );  
                    },
                  ),
                ),),
              )
            ],),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding: EdgeInsets.only(top: 0, left: 20), 
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3 ",style: TextStyle(color: Colors.red, fontSize: 15))
              ],),
            ),
          ),


          Padding(
            padding: EdgeInsets.all(15),
          ),
          Center(
            child: Container(
              width:60,
              height:60,
              child: Center( child: Ink(
                width:60,
                height:60,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: null,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [Color(0xFFAC0D57),Color(0xFFFC4A1F),]
                  ),
                  shadows: [BoxShadow( blurRadius: 5, color: Colors.grey, spreadRadius: 4.0, offset: Offset.fromDirection(1,1))],
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_forward,
                  size: 45,
                  color: Colors.white,),
                  onPressed: () async {//updating the edited information to the database
                    setState(() => validate=true);
                    if(!(logo==null || name==null)){
                      print(logo+','+name+' ${itemData.vendorId}');
                      await Firestore.instance.collection('item').document(itemData.itemId).setData({'name':name, 'logo':logo},merge: true).then((_)async{
                        await Firestore.instance.collection('ratedItems').where('itemId', isEqualTo: itemData.itemId).getDocuments().then((val) async{
                            val.documents.forEach((doc) async {
                              await Firestore.instance.collection('ratedItems').document(doc.documentID).setData({'name':name, 'logo':logo,},merge: true).catchError((e){err=e.toString();});
                            });
                        }).catchError((e){err=e.toString();});
                      }).catchError((e){err=e.toString();});
                      Navigator.pop(context);
                    }
                  }
                ),
              ),),
            ),
          ),
          SafeArea(
            child: err== null ? Container() : Container(
              padding:EdgeInsets.only( top: 5), 
              child: Column(
                children: <Widget>[
                  
                  Container(
                    alignment: Alignment(-0.8,-0.9),
                      child: Text(err,
                      style: TextStyle(color: Colors.red)
                      ),
                  ),
                ],
              )                        
            ),
          ),
        ],
        )  
      ),)
    ); 
  }
}

//description and declaration of the sidebar widget
class SideBarGeneral extends StatefulWidget {
  @override
  SideBarPropertiesGeneral createState() => new SideBarPropertiesGeneral();
}

class SideBarPropertiesGeneral extends State<SideBarGeneral>{

  UserData variable;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      Map<String, dynamic> userMap = json.decode(value);
      UserData finalObject = UserData.fromData(userMap);
      variable=finalObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(                                //the properties of the sidebar drawer
      child: new Column(
        
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Padding( padding: EdgeInsets.all(30),),
            CircleAvatar(                         //adding the profile image to the sidebar
              radius:70, 
              backgroundImage: NetworkImage('${myUserInfo.profilePicture}'),
            ),
            Text(                                 //displaying the name on the sidebar
              myUserInfo.firstName + ' ' + myUserInfo.lastName, 
              style: TextStyle(fontSize: 30, color: Colors.black)
            ),
            Text(                                 //displaying the user image on the sidebar
              myUserInfo.email, 
              style: TextStyle(fontSize: 22, color: Colors.black)
            ),
          Padding( padding: EdgeInsets.all(30),),
          Container(
            child: GestureDetector(             //leading to the edit profile screen
              onTap: () { //Change on Integration
                Navigator.push(context,MaterialPageRoute(builder: (context)=> EditProfile(userInfoRecieved: myUserInfo)),);
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
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Edit Profile',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
          Padding( padding: EdgeInsets.all(20),),
          Container(
            child: GestureDetector(
              onTap: () { //Change on Integration
                Navigator.popUntil(context, ModalRoute.withName('/'));
                //Navigator.push(context,MaterialPageRoute(builder: (context)=> HostitHomescreen()),);
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
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('View my Events',        //adding the view my events button
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
          Padding( padding: EdgeInsets.all(20),),
          Container(
            child: GestureDetector(             //signout from the application
              onTap:() async {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  await FirebaseAuth.instance.signOut();
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
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Sign Out',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}