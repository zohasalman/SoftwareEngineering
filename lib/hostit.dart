import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
//import 'dart:math' as math;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rateit/login.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'localData.dart';
import 'user.dart';
import 'Event.dart';
//import 'userRedirection.dart';
import 'dart:convert';
//import 'VendorList.dart';
import 'package:random_string/random_string.dart';
import 'hostit_first.dart';
import 'vendor.dart';
import 'vendorlist-hostit.dart';
import 'item.dart';
import 'item-list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
void main2() => runApp(App());

String number="8"; 
List<int> no=[2,3,4,5,6,7,8,9]; 


class ClipShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var clipline= new Path();
    clipline.lineTo(0, size.height-0);
    clipline.lineTo(size.width, size.height-100);
    clipline.lineTo(size.width, 0);
    return clipline;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
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

class AddEvent extends StatefulWidget {
  final LatLng coord;
  AddEvent({this.coord});
  
  @override 
  AddEventState createState()=> new AddEventState(coord: coord); 
}

class AddEventState extends State<AddEvent> {
  //AddEventState({this.eid});
  LatLng coord;
  AddEventState({this.coord});
  int eventNumber;
  String name;
  String logo, photo;  
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  void getCoordinates() async {
    final updatedcoord = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => Maps()),
    );
    coord=updatedcoord;
  }

  bool validate=false; 
  bool error1=false; 
  bool error2=false; 
  String err;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        //key: scaffoldKey,
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
            Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.90,
                  padding:EdgeInsets.only( top: 10, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (input)=> input.isEmpty? 'Please fill out this field': null,
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
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                      child: TextFormField(
                        validator: (tmp)=>coord==null?'Please fill out this field':null,
                        //validator: (input)=> input.isEmpty? 'Please enter a valid location': nu//coord=LatLng(23.32, 65.1);
                        decoration: InputDecoration(
                          labelText: coord==null?'Please Mark a Location':'(${coord.latitude},${coord.longitude})',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19
                          )
                        ),
                      )
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Ink(
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
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=> Maps()),);
                      },
                    ),
                  ),
                )
              ],),
            ),
            
            Container(
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
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  
                      child: TextFormField(
                        
                        validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                        onChanged: (input)=> logo=input,
                        decoration: InputDecoration(
                          labelText: 'Upload a logo of your event',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19
                          )
                        ),
                      )
                    
                  
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Ink(
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
                      onPressed: () {
                        setState(() {
                          error1=true; 
                        });
                      },
                    ),
                  ),
                )
              ],),
            ),
            
            Container(
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

            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                  child: TextFormField( 
                    validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                    onChanged: (input)=> photo=input,
                    decoration: InputDecoration(
                      labelText: 'Upload a photo of your event',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.10,
                  child: Ink(
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
                      onPressed: () {
                        setState(() {
                          error2=true; 
                        });
                      },
                    ),
                  ),
                )
              ],),
            ),

            Container(
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
                  //width: MediaQuery.of(context).copyWith().size.width * 0.20,
                  width:60,
                  height:60,
                  child: Ink(
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
                        setState(() => validate=true);
                        if(coord!=null){
                          GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);//23.0,66.0);
                          String eventid; 
                          var varEvent = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:randomAlphaNumeric(10), invitecode:randomAlpha(6), location1:eventLocation, name:name, logo:'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FLogo%2Fcokefest.png?alt=media&token=79d901a3-6308-40fa-8b4d-08c809e37691', coverimage:'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FCover%2Fcokefestcover.jpg?alt=media&token=7bbf5d5d-e5b8-4a31-a397-2d817e4dc347');
                          if ( !(name==null || logo==null || photo==null || eventNumber==null) ){
                            await Firestore.instance.collection("Event").add(varEvent.toJSON()).then((eid) async{
                                await Firestore.instance.collection('Event').document(eid.documentID).setData({'eventID':eid.documentID},merge: true).then((_){eventid=eid.documentID;}).catchError((e){err=e.toString();});
                            }).catchError((e){err=e.toString();});
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:eventNumber,eid:eventid,eventName:name)),);
                          }
                      }
                      },
                    ),
                  ),
            ),),
          ],
          )  
        ),
      )
    ); 
  }
}

class EventMenu extends StatefulWidget {
  final String eid;
  final String eventName;
  final String inviteCode;
  EventMenu({this.eid,this.eventName,this.inviteCode});
  @override 
  EventMenuState createState()=> new EventMenuState(eid:eid,eventName:eventName,inviteCode: inviteCode ); 
}

class EventMenuState extends State<EventMenu> {
  String eid;
  String eventName;
  String inviteCode;
  String err; 
  EventMenuState({this.eid,this.eventName,this.inviteCode});
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  var scaffoldKey=GlobalKey<ScaffoldState>();
  bool validate=false; 

  @override 
  Widget build(BuildContext context) {    
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
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
                        child: Text(eventName,style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                       
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
                      }),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
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
      body: Form(
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

            // Container(
            //     child: InkWell(
            //       onTap: (){
            //         Navigator.push(context,MaterialPageRoute(builder: (context)=> Comprehensive(eid:eid,eventName:eventName)),);
            //       },
            //       child: Container(
            //         height: 50,
            //         width: 350,
                    
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment.topRight,
            //             end: Alignment.topLeft,
            //             colors: [ 
            //               Color(0xFFAC0D57),
            //               Color(0xFFFC4A1F),
            //             ]
            //           ),
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //         padding: EdgeInsets.only(top: 15, left: 40), 
            //         child: Text("Generate Comprehensive Report",style: TextStyle(color: Colors.white, fontSize: 18 ))
            //       ),

            //     ),
              
            // ),

            
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
                    padding: EdgeInsets.only(top: 15, left: 90), 
                    child: Text("Download QR codes",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),

            SafeArea(
                child: InkWell(
                  onTap: ()async{
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
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=> ()),);  
                  },
                  child: SafeArea(
                  child: Container(
                  padding: EdgeInsets.only(top: 20), 
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
                    padding: EdgeInsets.only(top: 15, left: 115), 
                    child: Text("Email QR codes",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),),),

                ),
              
            ),

            SafeArea(
                child: InkWell(
                  onTap: (){
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
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewVendorHostIt(eventName: eventName,eventID: eid,)),);  
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
                  onTap: () async {
                    
                    Event varEvent;// = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:null, invitecode:null, location1:null, name:null, logo:null, coverimage:null);
                    await Firestore.instance.collection('Event').document(eid).get().then((value){
                      Event passEvent = new Event(uid:null, eventID:null, invitecode:null, location1:value.data['location1'], name:value.data['name'], logo:value.data['logo'], coverimage:value.data['coverimage']);
                      varEvent = passEvent;
                      //varEvent.logo = value.data['userRole'];
                    }).catchError((e){err=e.toString();});
                    if(varEvent!=null){
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

class AddVendorQty extends StatefulWidget {
  final String eid;
  final String eventName;
  AddVendorQty({this.eid,this.eventName});

  @override 
  Screen41 createState()=> new Screen41(eid:eid,eventName:eventName); 
}

class Screen41 extends State<AddVendorQty> {
  final String eid;
  int numVen;
  String eventName;
  String valSave;
  String err; 
  Screen41({this.eid,this.eventName});

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  List<DropdownMenuItem<String>> n=[];
  void loadData(){
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
  int custom_val; 
  String custom_valSave; 
  

  @override 
  Widget build(BuildContext context){
    loadData(); 
    return Scaffold(
        //key: scaffoldKey,
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
                        child: Text('Add Vendors',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      //size:24,
                    ), 
                    onPressed: (){
                      Navigator.pop(context);
                      }),
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
        child: Column(children: <Widget>[
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

          SafeArea(
              child: !(error1 && validate)? Container() : Container(
                // print(error1),
                // print(validate),
                
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

         
          SafeArea(
            child: valSave!="Custom"? Container() : Container(
              padding:EdgeInsets.only( top: 40, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input)=> input.isEmpty? 'Please enter a number': null,
                    onChanged: (input)=> custom_valSave=input,
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

          SafeArea (
            child: Container(
            padding:EdgeInsets.only( top: 50),
            child: Center(
            //offset: Offset(0,-50),
              child: SafeArea(
                child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{
                   
                  setState(() => validate = true),
                  if (valSave!=null && valSave!="Custom"){
                    numVen=int.parse(valSave),
                  //print(numVen),
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:numVen, eid:eid, eventName:eventName)),)

                  }

                  else if (valSave=="Custom" && custom_valSave!=null)
                  {
                    custom_val=int.parse(custom_valSave),
                    //print(numVen),
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:custom_val, eid:eid, eventName:eventName)),)

                  }
                  
                  
                } ),
              ),),
            ),
          ), ),      
        ],),  
      ),),
    ); 
  }
}

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
  List<String> email = new List<String>(), stallid = new List<String>();
  List<int> item = new List<int>();
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  var nu; 
  var n= int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  int count=2; 
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
                  TextSpan(
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
                  labelText: 'Stall Name',
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
                  labelText: 'Email ID',
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
                onChanged: (input)=> stallid[i]= input,
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
 
  void add6(i){
    menu2=List.from(menu2)..add(
            Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).copyWith().size.width * 0.75,
                  padding:EdgeInsets.only( top: 5, left: 20),
                
                  child: TextFormField(
                    
                    validator: (input)=> input.isEmpty? 'Please enter a logo': null,
                    decoration: InputDecoration(
                      labelText: 'Upload a logo of the vendor',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                  )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                    onPressed: () {
                      //Add Upload image function here
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=> Add()),);
                    },
                  ),
                ),
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
              
              TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
            ]
            )),
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
                onChanged: (input)=> item[i]= int.parse(input),
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

  bool validate=false; 
  bool error1=false; 

  String err;
  @override 
  Widget build(BuildContext context){
    
    if (!check && numVen>0){
      Padding(padding: EdgeInsets.only(top: 15));
      for (var i=0 ; i<numVen ; i++){
        name.add('');
        email.add('');
        stallid.add('');
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
              //key: scaffoldKey,
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
                        child: Text('Add Vendors',style: TextStyle(color: Colors.white, fontSize: 28 ))
                      ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                       
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
                      }),
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
            //width: MediaQuery.of(context).copyWith().size.width * 0.20,
            width:60,
            height:60,
            child: Ink(
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
                  setState(() => validate=true);
                  bool check =true;
                  List<String> venId = List<String>();
                  for(var i=0; i<numVen; i++){
                    if(name[i]=='' || email[i]=='' || stallid[i]=='' || item[i]==0|| !EmailValidator.validate(email[i], true)){
                      check=false;
                    }
                  }
                  if (check){
                    
                    for (var i=0; i<numVen; i++){
                        await Firestore.instance.collection("Vendor").add({'aggregateRating' : 0.0, 'email' : email[i], 'eventId' : eid, 'name' : name[i], 'stallNo' : int.parse(stallid[i]), 'logo':null }).then((vid) async{
                            await Firestore.instance.collection('Vendor').document(vid.documentID).setData({'qrCode' : vid.documentID, 'vendorId':vid.documentID,}, merge: true).then((_){venId.add(vid.documentID);}).catchError((e){err=e.toString();});
                        }).catchError((e){err=e.toString();});
                    }
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> Add(eid:eid,vid: venId, numVen: item,eventName:eventName)),);   //Modify here to upload Event Data and then move on
                  }
                },
              ),
            ),
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


class Add extends StatefulWidget {
  final String eid;
  final List<String> vid;
  final List<int> numVen;
  final String eventName;
  Add({this.eid,this.numVen,this.vid,this.eventName});

  @override 
  Screen45 createState()=> new Screen45(vid:vid, numVen:numVen, eid:eid, eventName:eventName); 
}

class Screen45 extends State<Add> {
  String eid;
  String eventName;
  List<String> vid;
  bool validate=false; 
  List<int> numVen;
  Screen45({this.eid,this.numVen,this.vid,this.eventName});
  List<List<String>> itemname = new List<List<String>>(),mlogo = new List<List<String>>();
  //List<String> itemcoll = new List<String>();
  bool value=false;
  bool check=false; 
  var n=int.parse(number); 
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
              validator: (input)=> input.isEmpty? 'Please enter menu item': null,
              onChanged: (input)=> itemname[i][j]=input,
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
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.75,
            padding:EdgeInsets.only( top: 5, left: 20),
            child: TextFormField(
              //keyboardType: TextInputType.number,
              validator: (input)=> input.isEmpty? 'Please upload a logo': null,
              onChanged: (input)=> mlogo[i][j]=input,
              decoration: InputDecoration(
                labelText: 'Upload a logo of the menu item',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            )
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.10,
            child: Ink(
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
                onPressed: () {
                  
                },
              ),
            ),
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
          //addvalue3(); 
        }
      }
      check=true; 
    }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
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
                  actions: <Widget>[
                       IconButton(
                        onPressed: () {                          
                          showSearch(
                            context: context,
                            delegate: MapSearchBar(),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          
                        )
                      ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
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
      body: Form(
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
              Container (
                child: Ink(
                  height: 100,
                  width: 200,
                  child: IconButton(
                    icon: new Image.asset("asset/image/icon.png"),
                    onPressed:() async {
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
                          
                          for (var i=0; i<numVen.length; i++){
                            for (var j=0; j<numVen[i]; j++){
                              //print(itemname[i][j]);
                                await Firestore.instance.collection("item").add({'aggregateRating':0.0,'logo':null,'name':itemname[i][j],'vendorId':vid[i]}).then((vid) async{
                                    await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){}).catchError((e){err=e.toString();});//venId.add(vid.documentID);});
                                }).catchError((e){err=e.toString();});
                            }
                          }
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> QRselection(eid:eid,eventName:eventName)),);   //Modify here to upload Event Data and then move on
                        }
                    },
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

class AddItem2 extends StatefulWidget {
  final String eid;
  final List<String> vid;
  final List<int> numVen;
  final String eventName;
  AddItem2({this.eid,this.numVen,this.vid,this.eventName});

  @override 
  AddItem2State createState()=> new AddItem2State(vid:vid, numVen:numVen, eid:eid, eventName:eventName); 
}

class AddItem2State extends State<AddItem2> {
  String eid;
  String eventName;
  List<String> vid;
  List<int> numVen;
  bool validate=false; 
  AddItem2State({this.eid,this.numVen,this.vid,this.eventName});
  List<List<String>> itemname = new List<List<String>>(),mlogo = new List<List<String>>();
  //List<String> itemcoll = new List<String>();
  bool value=false;
  bool check=false; 
  var n=int.parse(number); 

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
              //keyboardType: TextInputType.number,
              validator: (input)=> input.isEmpty? 'Please enter menu item': null,
              onChanged: (input)=> itemname[i][j]=input,
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
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.75,
            padding:EdgeInsets.only( top: 5, left: 20),
            child: TextFormField(
              //keyboardType: TextInputType.number,
              validator: (input)=> input.isEmpty? 'Please upload a logo': null,
              onChanged: (input)=> mlogo[i][j]=input,
              decoration: InputDecoration(
                labelText: 'Upload a logo of the menu item',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            )
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.10,
            child: Ink(
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
                onPressed: () {
                  
                },
              ),
            ),
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
          //addvalue3(); 
        }
      }
      check=true; 
    }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
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
                  actions: <Widget>[
                       IconButton(
                        onPressed: () {                          
                          showSearch(
                            context: context,
                            delegate: MapSearchBar(),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          
                        )
                      ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
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
      body: Form(
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
              Container (
                child: Ink(
                  height: 100,
                  width: 200,
                  child: IconButton(
                    icon: new Image.asset("asset/image/icon.png"),
                    onPressed:() async {
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
                          
                          for (var i=0; i<numVen.length; i++){
                            for (var j=0; j<numVen[i]; j++){
                              //print(itemname[i][j]);
                                await Firestore.instance.collection("item").add({'aggregateRating':0.0,'logo':null,'name':itemname[i][j],'vendorId':vid[i]}).then((vid) async{
                                    await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){}).catchError((e){err=e.toString();});//venId.add(vid.documentID);});
                                }).catchError((e){err=e.toString();});
                            }
                          }
                          Navigator.pop(context);
                        }
                    },
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


class EditVen extends StatefulWidget {
  final Vendor vendorData;
  final String eventName;
  EditVen({this.eventName,this.vendorData});
  @override 
  EditVenState createState()=> new EditVenState(vendorData: vendorData,eventName: eventName); 
}

class EditVenState extends State<EditVen> {
  String name,email,logo;
  int stallid;
  int item=0;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 
  Vendor vendorData;
  String eventName;
  EditVenState({this.eventName,this.vendorData});
  bool value=false;
  bool check=false; 
  bool validate=false; 



  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[];   
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
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
      //key: scaffoldKey,
      //endDrawer:  SideBar(),
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
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: InkWell(
              child: new Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
                //padding: EdgeInsets.only(top: 130, left: 20), 
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
                  validator: (input)=> input.isEmpty? 'Please enter vendor name': null,
                  onChanged: (input)=> name=input,
                  decoration: InputDecoration(
                    hintText: 'Stall Name',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller.clear());
                          //dcontroller.clear();
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
                TextFormField(
                  controller: dcontroller2,
                  validator: (input)=> input.isEmpty? 'Please enter vendor email': null,
                  onChanged: (input)=> email=input,
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller2.clear());
                          //dcontroller.clear();
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
                          //dcontroller.clear();
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
                
                    child: TextFormField(
                      controller: dcontroller3,
                      validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                      onChanged: (input)=> logo=input,
                      decoration: InputDecoration(
                        hintText: 'Upload a logo for your vendor',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: ()=>{
                            setState((){
                              WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller3.clear());
                              //dcontroller3.clear();
                            }),
                          },
                        ),
                      ),
                    )
                  
                
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                    onPressed: () {},
                  ),
                ),
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
          Container(
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
                  validator: (input)=> input.isEmpty? 'Please enter a number': null,
                  onChanged: (input) {
                    //print(input);
                    item=int.parse(input);
                    //print(item);
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
                child: Ink(
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
                      print(item);
                      if (item>0){//connect item here
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> AddItem2(eid:vendorData.eventId,numVen:[item],vid: [vendorData.vendorId],eventName: eventName,)),);
                      }
                    },
                  ),
                ),
              )
            ],),
          ),


          Padding(
            padding: EdgeInsets.all(15),
          ),
          Center(
            child: Container(
              //width: MediaQuery.of(context).copyWith().size.width * 0.20,
              width:60,
              height:60,
              child: Ink(
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
                    String err;
                    //if(coord!=null){
                    await Firestore.instance.collection('Vendor').document(vendorData.vendorId).setData({'name':name, 'logo':logo,'email':email,'stallNo':stallid},merge: true).then((_) async {
                      await Firestore.instance.collection('ratedVendor').where('vendorId', isEqualTo: vendorData.vendorId).getDocuments().then((val) async{
                          val.documents.forEach((doc) async {
                             await Firestore.instance.collection('ratedVendor').document(doc.documentID).setData({'name':name, 'logo':logo,'email':email,'stallNo':stallid},merge: true).catchError((e){err=e.toString();});
                          });
                      }).catchError((e){err=e.toString();});
                    }).catchError((e){err=e.toString();});
                    //}
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewItemHostIt(eventID:vendorData.eventId, eventName:vendorData.name, vendorID:vendorData.vendorId,)),);
                  }
                ),
              ),
            ),
          ),
        ],
        )  
      ),),
    ); 
  }
}



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

  String name, add, vendor, image, pic;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 

  
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  var nu; 
  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  int count=1; 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  void getCoordinates() async {
    final updatedcoord = await Navigator.push(
      context,
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
    //dcontroller2.text='${eventData.location1.latitude},${eventData.location1.longitude}';
    dcontroller3.text=eventData.logo;
    dcontroller4.text=eventData.coverimage;
  }
  @override 
  Widget build(BuildContext context){


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //key: scaffoldKey,
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
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
                          //dcontroller.clear();
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
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: coord==null?'Please Mark a Location':'(${coord.latitude},${coord.longitude})',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 19
                        )
                      ),
                    )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                ),
              )
            ],),
          ),
          

          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.75,
                padding:EdgeInsets.only( top: 5, left: 20),
                
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: coord==null?'Please upload logo photo of your event':'Image Uploaded',
                      ),
                    )
                  
                
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                    onPressed: () {},
                  ),
                ),
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
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: coord==null?'Please upload cover photo of your event':'Image Uploaded',
                  ),
                )
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                      File selected = await ImagePicker.pickImage(source:ImageSource.gallery);
                      FirebaseStorage(storageBucket:'gs://seproject-rateit.appspot.com/').ref().child('images/${DateTime.now()}.png').putFile(selected);

                    },
                  ),
                ),
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
          Padding(
            padding: EdgeInsets.all(15),
          ),
          Center(
            child: Container(
              //width: MediaQuery.of(context).copyWith().size.width * 0.20,
              width:60,
              height:60,
              child: Ink(
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
                    //if(coord!=null){
                    GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);//23.0,66.0);
                    String err;
                    await Firestore.instance.collection('Event').document(eid).setData({'name':savedName,'location1':eventLocation,'logo':savedLogo,'coverimage':savedCover},merge: true).catchError((e){err=e.toString();});
                    //}
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:savedName)),);
                  }
                ),
              ),
            ),
          ),
        ],
        )  
      )

      
    ); 
  }
}


class Comprehensive extends StatefulWidget {
  final String eid;
  final String eventName;
  Comprehensive({this.eid,this.eventName});
  @override 
  ComprehensiveReport createState()=> new ComprehensiveReport(eid:eid,eventName: eventName); 
}

class ComprehensiveReport extends State<Comprehensive> {
  String eventName;
  String eid;
  ComprehensiveReport({this.eid,this.eventName});
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        //key: scaffoldKey,
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
                        child: Text(eventName,style: TextStyle(color: Colors.white, fontSize: 28 ))
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
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container (
            child: Container(
              height: 200,
              width: 200,
              child:Icon(Icons.check_circle_outline,color: Colors.green[300],size: 200,), 
            ),
          ),

          //Container(
            //width: MediaQuery.of(context).copyWith().size.width * 0.96,
            //child:
            Row( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Container(
                    height: 50,
                    width: 50,
                    child:Icon(Icons.mail_outline,color: Colors.black,size: 50,),  
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: "Email Sent",style: TextStyle(color: Colors.black, fontSize: 30)),
                      ]),
                    ),
                  ),
                  Spacer(),
                ]
              ),
            //),
          //),
          Center(
              child: Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.96,
                //padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "A comprehensive report has been successfully emailed to you.\n",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: " Questions?\n",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: " Contact us on ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "help.rateit@gmail.com ",style: TextStyle(color: Colors.pink[800], fontSize: 17))
                  ]
                  )),

              ),
          ),
          Padding(padding: EdgeInsets.all(10),),
          Container(
            child: InkWell(
              onTap: ()async{
                String inviteCode,err;
                await Firestore.instance.collection('Event').document(eid).get().then((val) async{
                  inviteCode=val.data['invitecode'];
                }).catchError((e){err=e.toString();});
                Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventName,inviteCode:inviteCode)),);
              },
              child: Center(
                child:Container(
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
                child: Center(
                  child:Text("Done",style: TextStyle(color: Colors.white, fontSize: 22 ))
                ),
              ),),
            ),
          ),
        ],),  
      ),
    ); 
  }
}



class QRselection extends StatefulWidget {
  final String eid;
  final String eventName;
  QRselection({this.eid,this.eventName});

  @override
  ScreenQRselect createState() => new ScreenQRselect(eid:eid,eventName:eventName);
}

class ScreenQRselect extends State<QRselection> {
  String eid,eventName;
  ScreenQRselect({this.eid,this.eventName});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        //key: scaffoldKey,
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
                        child: Text('QR Code',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                       
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
                      }),
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
                              onTap: ()async{
                                String inviteCode,err;
                                await Firestore.instance.collection('Event').document(eid).get().then((val) async{
                                  inviteCode=val.data['invitecode'];
                                }).catchError((e){err=e.toString();});
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventName,inviteCode:inviteCode)),);
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
                                child:Center(
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
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: 
                          Container(
                            child: GestureDetector(
                              onTap: ()async{
                                String inviteCode,err;
                                await Firestore.instance.collection('Event').document(eid).get().then((val) async{
                                  inviteCode=val.data['invitecode'];
                                }).catchError((e){err=e.toString();});
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventName,inviteCode:inviteCode)),);
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
                                child:Center(
                                  child: 
                                    Text('Email QR Codes',
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
                    ],
                  ),
              ),
            ],
          ),
        )
      )
    );
  }
}

class Maps extends StatefulWidget {
  //Maps(LatLng eid);

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
                        child: Text('Location',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                    )
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,    
                      ), 
                    onPressed: (){
                      //coord=LatLng(23.32, 65.1);
                      Navigator.pop(context, coord);
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=> AddEvent(coord: coord)),);
                    }
                  ),
                  // actions: <Widget>[
                  //   IconButton(
                  //     onPressed: () {                     
                  //       showSearch(
                  //           context: context,
                  //           delegate: MapSearchBar(),
                  //       );
                  //     },
                  //     icon: Icon(
                  //       Icons.search,
                      
                  //     )
                  //     ),
                  //   Padding(
                  //     padding: EdgeInsets.only(right: 20.0),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         scaffoldKey.currentState.openEndDrawer();
                  //         },
                  //       child: Icon(
                  //           Icons.menu,
                          
                  //       ),
                  //     )
                  //   ),
                  //],
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
        GoogleMap(
          onTap: (LatLng coordinates){
                final Marker marker1 = Marker(
                  markerId: MarkerId('1'),
                  draggable: true,
                  position: coordinates,
                );
                setState(() {
                  markerSet.clear();
                  markerSet.add(marker1);
                  marker=marker1;
                  coord=coordinates;
                });
          },
          markers: markerSet,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
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

class MapSearchBar extends SearchDelegate<String>  {

   List<String> _list = const [
      'Igor Minar',
      'Brad Green',
      'Dave Geddes',
      'Naomi Black',
      'Greg Weber',
      'Dean Sofer',
      'Wes Alvaro',
      'John Scott',
      'Daniel Nadasi',
  ];

  @override
  String get searchFieldLabel => super.searchFieldLabel;
  @override
  ThemeData appBarTheme(BuildContext context){
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColorDark: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {query='';},
        child: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child:  Icon(
            Icons.clear,
            size: 20,
          ),
        ),
    ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: new Icon(Icons.arrow_back_ios),
      onPressed:()=>Navigator.pop(context),
    );
      
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Hi");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 5,
      itemBuilder: (context,index) {
        return ListTile(
            title: Text(_list[index]),
        );
      },
    );
  }
}

class SideBar extends StatefulWidget {
  @override
  SideBarProperties createState() => new SideBarProperties();
}

class SideBarProperties extends State<SideBar>{
  UserData variable;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      Map<String, dynamic> userMap = json.decode(value);
      UserData finalObject = UserData.fromData(userMap);
      variable=finalObject;
      //variable=user;
    });
  }

  void normalSignOut() async {
    User usr = Provider.of<User>(context, listen: false);
    String user = usr.uid;
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
            Padding( padding: EdgeInsets.all(30),),
            CircleAvatar(
              radius:70, 
              backgroundImage: AssetImage("asset/image/user.png"),
            ),
            Text((() {
                if(variable==null){return "Aladin";}  // your code here
                else{return "nadnvaf";}
              }()),
              style: TextStyle(fontSize: 30, color: Colors.black)
            ),
            Text(
              'Aladin@hotmail.com', 
              style: TextStyle(fontSize: 22, color: Colors.black)
            ),
          Padding( padding: EdgeInsets.all(30),),
          Container(
            child: GestureDetector(
              onTap: () { //Change on Integration
                Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);
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
                Navigator.push(context,MaterialPageRoute(builder: (context)=> HostitHomescreen()),);
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
                    Text('View my Events',
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
              onTap:() async {await FirestoreService().normalSignOutPromise();},
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


class ViewVendorHostIt extends StatefulWidget {
  ViewVendorHostIt({this.eventName, this.eventID});
  final String eventName;
  final String eventID;

  @override
  State<StatefulWidget> createState() {
    return _ViewVendorHostIt(eventName: eventName,eventID: eventID);
  }
}

class _ViewVendorHostIt extends State<ViewVendorHostIt> {
  _ViewVendorHostIt({this.eventName, this.eventID});
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
    // final vendorFromDB = Provider.of<List<Vendor>>(context);

    return StreamProvider<List<Vendor>>.value(
      value: FirestoreService().getVendorInfo(eventID),
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
                    leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,    
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
                    }
                  ),
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 40.0, left: 10),
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
                      )
                    ),
                  )
                ],
              ),
              clipper: Clipshape(),
            )),
        endDrawer: SideBar2(),
        body://Column( children: <Widget>[
          VendorsListHostit(eventName: eventName,),
        //]),
      ),
    );
  }
}


class ViewItemHostIt extends StatefulWidget {
  ViewItemHostIt({this.vendorID,this.eventName, this.eventID});
  final String eventName;
  final String eventID;
  final String vendorID;

  @override
  State<StatefulWidget> createState() {
    return _ViewItemHostIt(eventName: eventName,eventID: eventID,vendorID: vendorID,);
  }
}

class _ViewItemHostIt extends State<ViewItemHostIt> {
  _ViewItemHostIt({this.vendorID,this.eventName, this.eventID});
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
    // final vendorFromDB = Provider.of<List<Vendor>>(context);

    return StreamProvider<List<Item>>.value(
      value: FirestoreService().getItemInfo(vendorID),
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
                    leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,    
                      ), 
                    onPressed: (){
                      Navigator.pop(context);
                    }
                  ),
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
        endDrawer: SideBar2(),
        body:Column( 
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Text(
                "Long Press to delete item",
                style: TextStyle(color: Colors.pink[600], fontSize: 17),
              ),
            ), 
            //Expanded(
            Container(child:ListItemHostIt(eventName: eventName,eventID: eventID,)),
            // Padding(
            //   padding: EdgeInsets.all(15),
            // ),
//),
          ]
        ),
      ),
    );
  }
}

class EditItem extends StatefulWidget {
  final Item itemData;
  EditItem({this.itemData});
  @override 
  EditItemState createState()=> new EditItemState(itemData: itemData,); 
}

class EditItemState extends State<EditItem> {
  String name,logo;
  final dcontroller=new TextEditingController();
  final dcontroller3=new TextEditingController();
  Item itemData;
  EditItemState({this.itemData});
  bool value=false;
  bool check=false; 
  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

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
    name= itemData.name;
    logo= itemData.logo;
    dcontroller.text= itemData.name;
    dcontroller3.text= itemData.logo;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //key: scaffoldKey,
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
                actions: <Widget>[
                  IconButton(
                    onPressed: () {                          
                      showSearch(
                        context: context,
                        delegate: MapSearchBar(),
                      );
                    },
                    icon: Icon(
                      Icons.search,
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width * 0.90,
            child: InkWell(
              child: new Container(
              width: MediaQuery.of(context).copyWith().size.width * 0.90,
                //padding: EdgeInsets.only(top: 130, left: 20), 
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Item Details",
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
                  validator: (input)=> input.isEmpty? 'Please enter item name': null,
                  onChanged: (input)=> name=input,
                  decoration: InputDecoration(
                    hintText: 'Item Name',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller.clear());
                          //dcontroller.clear();
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
                
                    child: TextFormField(
                      controller: dcontroller3,
                      validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                      onChanged: (input)=> logo=input,
                      decoration: InputDecoration(
                        hintText: 'Upload a logo for item',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: ()=>{
                            setState((){
                              WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller3.clear());
                              //dcontroller3.clear();
                            }),
                          },
                        ),
                      ),
                    )
                  
                
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.10,
                child: Ink(
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
                    onPressed: () {},
                  ),
                ),
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
              //width: MediaQuery.of(context).copyWith().size.width * 0.20,
              width:60,
              height:60,
              child: Ink(
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
                  onPressed: () async {
                    String err;
                    //if(coord!=null){
                    await Firestore.instance.collection('item').document(itemData.vendorId).setData({'name':name, 'logo':logo},merge: true).then((_)async{
                      await Firestore.instance.collection('ratedItems').where('itemId', isEqualTo: itemData.itemId).getDocuments().then((val) async{
                          val.documents.forEach((doc) async {
                             await Firestore.instance.collection('ratedItems').document(doc.documentID).setData({'name':name, 'logo':logo,},merge: true).catchError((e){err=e.toString();});
                          });
                      }).catchError((e){err=e.toString();});
                    }).catchError((e){err=e.toString();});
                    //}
                    Navigator.pop(context);
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewItemHostIt(eventID:vendorData.eventId, eventName:eventName, vendorID:vendorData.vendorId,)),);
                  }
                ),
              ),
            ),
          ),
        ],
        )  
      )
    ); 
  }
}