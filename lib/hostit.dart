import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rateit/login.dart';
import 'package:rateit/rateit.dart';
import 'firestore.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'localData.dart';
import 'user.dart';
import 'Event.dart';
import 'userRedirection.dart';
import 'dart:convert';
import 'VendorList.dart';
import 'package:random_string/random_string.dart';
import 'hostit_first.dart';
import 'vendor.dart';
import 'vendorlist-hostit.dart';

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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.90,
                padding:EdgeInsets.only( top: 10, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input)=> input.isEmpty? 'Please enter a name': null,
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
                      validator: (tmp)=>coord==null?'Please Mark a Location':'(${coord.latitude},${coord.longitude})',
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
                    TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
                  ]
                  )),

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
                      //if(coord!=null){
                        GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);//23.0,66.0);
                        String eventid;
                        var varEvent = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:randomAlphaNumeric(10), invitecode:randomAlpha(6), location1:eventLocation, name:name, logo:'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FLogo%2Fcokefest.png?alt=media&token=79d901a3-6308-40fa-8b4d-08c809e37691', coverimage:'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FCover%2Fcokefestcover.jpg?alt=media&token=7bbf5d5d-e5b8-4a31-a397-2d817e4dc347');
                        if ( !(name==null || logo==null || photo==null || eventNumber==null) ){
                          await Firestore.instance.collection("Event").add(varEvent.toJSON()).then((eid) async{
                              await Firestore.instance.collection('Event').document(eid.documentID).setData({'eventID':eid.documentID},merge: true).then((_){eventid=eid.documentID;});
                          });
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:eventNumber,eid:eventid,eventName:name)),);
                        }
                     // }
                    },
                  ),
                ),
          ),),
        ],
        )  
      )
    ); 
  }
}

class EventMenu extends StatefulWidget {
  final String eid;
  final String eventName;
  EventMenu({this.eid,this.eventName});
  @override 
  EventMenuState createState()=> new EventMenuState(eid:eid,eventName:eventName ); 
}

class EventMenuState extends State<EventMenu> {
  final String eid;
  final String eventName;
  EventMenuState({this.eid,this.eventName});


   
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  var scaffoldKey=GlobalKey<ScaffoldState>();
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
        key: _formKey, child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
            
            Container(
              child: InkWell(
                onTap: (){
                
              },
              child: new Container(
                //padding: EdgeInsets.only(top: 130, left: 20), 
                child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "Invite code| ",style: TextStyle(color: Colors.grey[600], fontSize: 25)),
                  TextSpan(text: " AB64z9 ",style: TextStyle(color: Colors.black, fontSize: 25 )),

                ]
                )
                
              ),
                
              ),
              ),
              
            ),

            Container(
              child: Padding(
                padding:EdgeInsets.only(top: 0, left: 0), 
                child: Container(
                  height: 1, 
                  width: 350, 
                  color: Colors.black,),
                ),
              
            ),

            Container(
                child: InkWell(
                  onTap: (){
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);  
                  },
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
                    padding: EdgeInsets.only(top: 15, left: 40), 
                    child: Text("Generate Comprehensive Report",style: TextStyle(color: Colors.white, fontSize: 18 ))
                  ),

                ),
              
            ),

            
            Container(
                child: InkWell(
                  onTap: (){
                    
                  },
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
                  ),

                ),
              
            ),

            Container(
                child: InkWell(
                  onTap: (){
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=> ()),);  
                  },
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
                  ),

                ),
              
            ),

            Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendorQty(eid: eid, eventName: eventName,)),);
                  },
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
                  ),

                ),
              
            ),

            Container(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EditVen()),);  
                  },
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
                  ),

                ),
              
            ),

            Container(
                child: InkWell(
                  onTap: () async {
                    Event varEvent;// = new Event(uid:Provider.of<User>(context, listen: false).uid.toString(), eventID:null, invitecode:null, location1:null, name:null, logo:null, coverimage:null);
                    //await Firestore.instance.collection('Event').document(eid.documentID).setData({'eventID':eid.documentID},merge: true);
                    await Firestore.instance.collection('Event').document(eid).get().then((value){
                      Event passEvent = new Event(uid:null, eventID:null, invitecode:null, location1:value.data['location1'], name:value.data['name'], logo:value.data['logo'], coverimage:value.data['coverimage']);
                      varEvent = passEvent;
                      //varEvent.logo = value.data['userRole'];
                    });
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EditEvent(eid:eid,coord:LatLng(varEvent.location1.latitude, varEvent.location1.longitude) ,eventData:varEvent, )));
                  },
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

                ),
              
            ),
          ],),
        )  
      )
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
        child: Column(children: <Widget>[
          Container(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "How many vendors would you like to add?",style: TextStyle(color: Colors.black, fontSize: 20))
                  ],),
                ),
              ),
            ),
          ),

          Container (
            child: Center(
            
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

              child: Container(
                child: Center(
                
                  child:DropdownButton<String>(
                    value:valSave, 
                    items:n, 
                    onChanged: (value){
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
                ), 
              ), 
            ), 
            ),
          ),

         
          Container(
            child: valSave!="Custom"? Container() : Container(
              padding:EdgeInsets.only( top: 80, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input)=> input.isEmpty? 'Please enter a number': null,
                    onChanged: (input)=> valSave=input,
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

          Expanded (
            child: Center(
            //offset: Offset(0,-50),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{
                  numVen=int.parse(valSave),
                  //print(numVen),
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor(numVen:numVen, eid:eid, eventName:eventName)),)
                } ),
              ),
            ),
          ),         
        ],),  
      )
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
            //padding: EdgeInsets.only(top: 130, left: 20), 
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
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
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
                validator: (input)=> input.isEmpty? 'Please enter an email ': null,
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[  
          Center(
            child: Column(
            children: menu2),
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
                  bool check =true;
                  List<String> venId = List<String>();
                  for(var i=0; i<numVen; i++){
                    if(name[i]=='' || email[i]=='' || stallid[i]=='' || item[i]==0){
                      check=false;
                    }
                  }
                  if (check){
                    for (var i=0; i<numVen; i++){
                        await Firestore.instance.collection("Vendor").add({'aggregateRating' : 0.0, 'email' : email[i], 'eventID' : eid, 'name' : name[i], 'stallNo' : stallid[i], 'logo':null }).then((vid) async{
                            await Firestore.instance.collection('Vendor').document(vid.documentID).setData({'qrCode' : vid.documentID, 'vendorId':vid.documentID,}, merge: true).then((_){venId.add(vid.documentID);});
                        });
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
      )

      
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
  List<int> numVen;
  Screen45({this.eid,this.numVen,this.vid,this.eventName});
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Center( 
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: menu2
                ),
              ), 
              Container (
                child: Ink(
                  height: 100,
                  width: 200,
                  child: IconButton(
                    icon: new Image.asset("asset/image/icon.png"),
                    onPressed:() async {
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
                                    await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){});//venId.add(vid.documentID);});
                                });
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
      )
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Center( 
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: menu2
                ),
              ), 
              Container (
                child: Ink(
                  height: 100,
                  width: 200,
                  child: IconButton(
                    icon: new Image.asset("asset/image/icon.png"),
                    onPressed:() async {
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
                                    await Firestore.instance.collection("item").document(vid.documentID).setData({'itemId' : vid.documentID, }, merge: true).then((_){});//venId.add(vid.documentID);});
                                });
                            }
                          }
                          Navigator.pop(context);
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=> EditVen()),);   //Modify here to upload Event Data and then move on
                        }
                    },
                  ),
                ),
              ),
            ],
          )
        )  
      )
    ); 
  }
}


class EditVen extends StatefulWidget {
  @override 
  EditVenState createState()=> new EditVenState(); 
}

class EditVenState extends State<EditVen> {
  String name,email, stallid,logo;
  int item;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 
  String inputname="Carbie", inputemail="zohasalman123@gmail.com", inputstallid="112344", inputimage="carbie.png", inputmenunumber="8";
  int numVen;
  String eid;
  String eventName;
  EditVenState({this.eventName,this.numVen,this.eid});
  bool value=false;
  bool check=false; 



  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 


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
                  //onChanged: (input)=> savedName=input,
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
                  controller: dcontroller,
                  validator: (input)=> input.isEmpty? 'Please enter vendor email': null,
                  //onChanged: (input)=> savedName=input,
                  decoration: InputDecoration(
                    hintText: 'Email ID',
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
                  controller: dcontroller,
                  validator: (input)=> input.isEmpty? 'Please enter stall id': null,
                  //onChanged: (input)=> savedName=input,
                  decoration: InputDecoration(
                    hintText: 'Stall ID',
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
                      //onChanged: (input)=> savedLogo=input,
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
                TextSpan(text: "Enter a valure to add more Items:",style: TextStyle(color: Colors.black,fontSize: 20))
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
                  //onChanged: (input)=> eventNumber=int.parse(input),
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
                    onPressed: () {},
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
                    //if(coord!=null){
                    //await Firestore.instance.collection('Event').document(eid).setData({'name':savedName,'location1':eventLocation,'logo':savedLogo,'coverimage':savedCover},merge: true);
                    //}
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:savedName)),);
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

class Edit extends StatefulWidget {
  @override 
  Screen48 createState()=> new Screen48(); 
}

class Screen48 extends State<Edit> {
  String name,email, stallid,item;
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  var nu; 

  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  

  void addvalue(j){
    menu2=List.from(menu2)..add(
       Container(
        child: Transform.translate(
        offset: Offset(0,-70),
        child: new Container(
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              //keyboardType: TextInputType.number,
              validator: (input)=> input.isEmpty? 'Please enter menu item': null,
              onSaved: (input)=> item=input,
              decoration: InputDecoration(
                labelText: 'Menu Item $j',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19
                )
              ),
            ),
          ],
        ),
        ),
        ),
       )

    
      
      );

      setState(() {
        
      });

  }

    void addvalue2(){
    menu2=List.from(menu2)..add(
      Container(
      child: Transform.translate(
      offset: Offset(0,-60),
      child: new Container(
      padding:EdgeInsets.only( top: 0, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          TextFormField(
            //keyboardType: TextInputType.number,
            validator: (input)=> input.isEmpty? 'Please upload a logo': null,
            onSaved: (input)=> mlogo=input,
            decoration: InputDecoration(
              labelText: 'Upload a logo of the menu item',
              labelStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 19
              )
            ),
          )
        ]),
      ),
      ),),

     
      
      );

      setState(() {
        
      });

  }

  void addvalue3(){
    menu2=List.from(menu2)..add(
     
      Container (
        child: Transform.translate(
        offset: Offset(170,-110),
          child: Container(
            height: 50,
            width: 250,
            child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
          ),
        ),
      ),
      
      );

      setState(() {
        
      });


      

  }

  
  void add2(i){
    menu2=List.from(menu2)..add(
     
      Container(
      child: Transform.translate(
        offset: Offset(-140,-50),
        child: InkWell(
        child: new Container(
          //padding: EdgeInsets.only(top: 130, left: 20), 
          child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: "Vendor $i",style: TextStyle(color: Colors.black, fontSize: 22))
          ]
          )),
        ),
        ),
        ),
      ),
      
      );

      setState(() {
        
      });

  }
 
 

  @override 
  Widget build(BuildContext context){

    
    
    {
       if (!check)
      {
        for (var i=0; i<n; i++)
        {
          add2(i+1);
          for (var j=0; j<no[i]; j++){
            addvalue(j+1); 
            addvalue2(); 
            addvalue3(); 
          }
        }
        check=true; 
      }
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          
          Container(
            child: Column(
            children: menu2),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,0),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{} ),
              ),
            ),
          ),
      


          
        ],
        )  
      )

      
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
  GeoPoint savedLocation=null;
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
  Widget build(BuildContext context){
    savedName=eventData.name;
    savedLocation=GeoPoint(coord.latitude, coord.longitude);
    savedLogo=eventData.logo;
    savedCover=eventData.coverimage;
    dcontroller.text=eventData.name;
    //dcontroller2.text='${eventData.location1.latitude},${eventData.location1.longitude}';
    dcontroller3.text=eventData.logo;
    dcontroller4.text=eventData.coverimage;

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
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width * 0.75,
                padding:EdgeInsets.only( top: 5, left: 20),
                
                    child: TextFormField(
                      controller: dcontroller3,
                      validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                      onChanged: (input)=> savedLogo=input,
                      decoration: InputDecoration(
                        hintText: 'Upload a logo of your event',
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
                  controller: dcontroller4,
                  validator: (input)=> input.isEmpty? 'Please enter a valid photo': null,
                  onChanged: (input)=> savedCover=input,
                  decoration: InputDecoration(
                    hintText: 'Upload a photo of your event',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=>{
                        setState((){
                          WidgetsBinding.instance.addPostFrameCallback( (_) => dcontroller4.clear());
                          //dcontroller4.clear();
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
                    await Firestore.instance.collection('Event').document(eid).setData({'name':savedName,'location1':eventLocation,'logo':savedLogo,'coverimage':savedCover},merge: true);
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

class Screen extends StatefulWidget {
  @override 
  SuccessScreen createState()=> new SuccessScreen(); 
}



class SuccessScreen extends State<Screen> {
  String event="Karachi Eat";
  var scaffoldKey=GlobalKey<ScaffoldState>();
 final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  @override 

  Widget build(BuildContext context){
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
                        child: Text(event,style: TextStyle(color: Colors.white, fontSize: 28 ))
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
        child: Column(children: <Widget>[
          Container (
            child: Transform.translate(
            offset: Offset(0,0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/check.png")
                    ),
                ), 
              ),
            ),
          ),

           Container(
            child: Transform.translate(
            offset: Offset(0,30),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Success",style: TextStyle(color: Colors.black, fontSize: 52)),
                  
                  ]
                  )),
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
  @override 
  LostCount createState()=> new LostCount(); 
}



class LostCount extends State<Comprehensive> {
  String event="Karachi Eat"; 
 final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
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
                        child: Text(event,style: TextStyle(color: Colors.white, fontSize: 28 ))
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
        child: Column(children: <Widget>[
          Container (
            child: Transform.translate(
            offset: Offset(0,0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/check.png")
                    ),
                ), 
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-70,0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/envelope.png")
                    ),
                ), 
              ),
            ),
          ),
          
           Container(
            child: Transform.translate(
            offset: Offset(20,-65),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                  
                  ]
                  )),

              ),
            ),
           ),

          Container(
            child: Transform.translate(
            offset: Offset(20,-40),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "A comprehensive report has been successfully emailed to you.",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: " Questions?",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: " Contact us on ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "help.rateit@gmail.com ",style: TextStyle(color: Colors.pink[800], fontSize: 17))
                  ]
                  )),

              ),
            ),
          ),

           
            Container(
              child: Transform.translate(
              offset: Offset(0,20),
              child: InkWell(
                onTap: (){
                  
                },
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
                  padding: EdgeInsets.only(top: 15, left: 105), 
                  child: Text("Done",style: TextStyle(color: Colors.white, fontSize: 22 ))
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

// class ViewVendorHostit extends StatefulWidget {

// 	@override
//   State<StatefulWidget> createState() {

//     return _ViewVendorHostit();
//   }
// }

// class _ViewVendorHostit extends State<ViewVendorHostit> {
//   List<VendorList> vendors = [
//     VendorList(vendorname: 'Cloud Naan', flag: 'cloudnaan.png'),
//     VendorList(vendorname: 'KFC', flag: 'kfc.png'),
//     VendorList(vendorname: 'McDonalds', flag: 'mcdonalds.png'),
//     VendorList(vendorname: 'No Lies Fries', flag: 'noliesfries.png'),
//     VendorList(vendorname: 'Caffe Parha', flag: 'caffeparha.png'),
//     VendorList(vendorname: 'DOH', flag: 'doh.png'),
//     VendorList(vendorname: 'Carbie', flag: 'carbie.png'),
//     VendorList(vendorname: 'The Story', flag: 'thestory.png'),
//     VendorList(vendorname: 'Meet the Cheese', flag: 'meetthecheese.png'),
    
//   ];
//    var scaffoldKey=GlobalKey<ScaffoldState>();

  
//   @override 
//   Widget build(BuildContext context) {
//      return Scaffold(
//         key: scaffoldKey,
//         endDrawer:  SideBar(),
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(150.0),
//           child: ClipPath(
//             child: Stack(
//               fit: StackFit.expand,
//               children: <Widget>[

//                 AppBar(
//                   centerTitle: true,
//                   bottom: PreferredSize(
//                     preferredSize: Size.fromHeight(0),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 40.0, left: 10),
//                         child: Text('Vendor',style: TextStyle(color: Colors.white, fontSize: 28 ))
//                         ),
//                     )
//                   ),
//                   leading: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,
                       
//                       ), 
//                     onPressed: (){
//                       Navigator.pop(context);
//                       }),
//                   actions: <Widget>[
//                        IconButton(
//                         onPressed: () {                          
//                           showSearch(
//                             context: context,
//                             delegate: MapSearchBar(),
//                           );
//                         },
//                         icon: Icon(
//                           Icons.search,
                        
//                         )
//                       ),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 10.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           scaffoldKey.currentState.openEndDrawer();
//                           },
//                         child: Icon(
//                             Icons.menu,
                          
//                         ),
//                       )
//                     ),
//                   ],
//                   flexibleSpace: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.topLeft,
//                         colors: [ 
//                           Color(0xFFAC0D57),
//                           Color(0xFFFC4A1F),
//                         ]
//                     ),
//                       image: DecorationImage(
//                         image: AssetImage(
//                           "asset/image/Chat.png",
//                         ),
//                         fit: BoxFit.fitWidth,
//                     ),
//                   )
//                 ),
//                 )
//               ],
//             ),
//             clipper: ClipShape(),
//           )
//         ),
//       body: Stack(
//         children: <Widget>[
//       Container(
//         child: Transform.translate(
//         offset: Offset(0,140),
      
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: vendors.length,
//         itemBuilder: (context, index){
//           return Card(
//             child: ListTile(
//               onLongPress: ()=> {},
//               onTap: () {
//                 debugPrint('${vendors[index].vendorname} is pressed!');
//               },
//               title: Text(vendors[index].vendorname),
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage('asset/image/${vendors[index].flag}'),
//               ),
              
//             ),
//           );
//         }
//       ),),),


//       ],
//       ),
//     );
//   }
// }

class ViewVendor2 extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return _ViewVendor2();
  }
}

class _ViewVendor2 extends State<ViewVendor2> {

  var scaffoldKey=GlobalKey<ScaffoldState>();

  List<VendorList> vendors = [
    VendorList(vendorname: 'Cloud Naan', flag: 'cloudnaan.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'KFC', flag: 'kfc.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'McDonalds', flag: 'mcdonalds.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'No Lies Fries', flag: 'noliesfries.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'Caffe Parha', flag: 'caffeparha.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'DOH', flag: 'doh.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'Carbie', flag: 'carbie.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'The Story', flag: 'thestory.png', vendorrating: '4.5/5'),
    VendorList(vendorname: 'Meet the Cheese', flag: 'meetthecheese.png', vendorrating: '4.5/5'),
    
  ];

  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Text('Delete Vendor',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
      body: Stack(
        children: <Widget>[
          Container(
            child: Transform.translate(
            offset: Offset(120,170),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Swipe to dismiss",style: TextStyle(color: Colors.pink[600], fontSize: 17)),
                  ]
                  )),
              ),
            ),
          ),
          

      Container(
        child: Transform.translate(
        offset: Offset(0,190),
      
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vendors.length,
        itemBuilder: (context, index){

          return new Dismissible(
            key: new Key(vendors[index].vendorname), 
            onDismissed: (direction){

              vendors.removeAt(index); 
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Item dismissed")));
              
              
            },
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Confirm"),

                    content: Text("Are you sure you want to delete this vendor?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: ()=>Navigator.of(context).pop(true),
                        child: Text("Delete"),
                      ),
                      FlatButton(
                        onPressed: ()=>Navigator.of(context).pop(false),
                        child: Text("Cancel"),
                      )
                    ],
                  ); 
                },
              ); 
            },
          
          
            child: ListTile(
      
              title: Text(vendors[index].vendorname),
              leading: CircleAvatar(
                backgroundImage: AssetImage('asset/image/${vendors[index].flag}'),
              ),
              
            ),
          );

          

         
        }
      ),),),


      ],
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
                              onTap: () { //Change on Integration
                                 Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventName)),);
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
                              onTap: () { //Change on Integration
                                 Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:eid,eventName:eventName)),);
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



// class EditMaps extends StatefulWidget {
//   //Maps(LatLng eid);

//   @override
//   EditMapsFunc createState() => EditMapsFunc();
// }


// class EditMapsFunc extends State<EditMaps> {
//   LatLng coord;
//   Completer<GoogleMapController> _controller = Completer();
//   Marker marker=Marker(
//     markerId: MarkerId("1"),
//     draggable: true
//   ); //storing position coordinates in the variable
//   Set<Marker> markerSet={};
//   var scaffoldKey=GlobalKey<ScaffoldState>();
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: scaffoldKey,
//         extendBodyBehindAppBar: true,
//         endDrawer:  SideBar(),
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(150.0),
//           child: ClipPath(
//             child: Stack(
//               fit: StackFit.expand,
//               children: <Widget>[

//                 AppBar(
//                   centerTitle: true,
//                   bottom: PreferredSize(
//                     preferredSize: Size.fromHeight(0),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 40.0, left: 10),
//                         child: Text('Location',style: TextStyle(color: Colors.white, fontSize: 28 ))
//                         ),
//                     )
//                   ),
//                   leading: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,    
//                       ), 
//                     onPressed: (){
//                       if (coord != null)
//                         Navigator.pop(context, coord);
//                       //coord=LatLng(23.32, 65.1);
//                       //Navigator.push(context,MaterialPageRoute(builder: (context)=> EditEvent(eid: eid,coord: coord)),);
//                     }
//                   ),
//                   // actions: <Widget>[
//                   //   IconButton(
//                   //     onPressed: () {                     
//                   //       showSearch(
//                   //           context: context,
//                   //           delegate: MapSearchBar(),
//                   //       );
//                   //     },
//                   //     icon: Icon(
//                   //       Icons.search,
                      
//                   //     )
//                   //     ),
//                   //   Padding(
//                   //     padding: EdgeInsets.only(right: 20.0),
//                   //     child: GestureDetector(
//                   //       onTap: () {
//                   //         scaffoldKey.currentState.openEndDrawer();
//                   //         },
//                   //       child: Icon(
//                   //           Icons.menu,
                          
//                   //       ),
//                   //     )
//                   //   ),
//                   //],
//                   flexibleSpace: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.topLeft,
//                         colors: [ 
//                           Color(0xFFAC0D57),
//                           Color(0xFFFC4A1F),
//                         ]
//                     ),
//                       image: DecorationImage(
//                         image: AssetImage(
//                           "asset/image/Chat.png",
//                         ),
//                         fit: BoxFit.fitWidth,
//                     ),
//                   )
//                 ),
//                 )
//               ],
//             ),
//             clipper: ClipShape(),
//           )
//         ),

//         body:     
//         GoogleMap(
//           onTap: (LatLng coordinates){
//                 final Marker marker1 = Marker(
//                   markerId: MarkerId('1'),
//                   draggable: true,
//                   position: coordinates,
//                 );
//                 setState(() {
//                   markerSet.clear();
//                   markerSet.add(marker1);
//                   marker=marker1;
//                   coord=coordinates;
//                 });
//           },
//           markers: markerSet,
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: LatLng(30, 68),
//             zoom: 5,
//           ),
//           mapType: MapType.hybrid,
//           rotateGesturesEnabled: true,
//           scrollGesturesEnabled: true,
//           tiltGesturesEnabled: true,
//           myLocationEnabled: true,          
//         ),
//       ),
//     );
//   }
// }

















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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      Map<String, dynamic> userMap = json.decode(value);
      UserData final_object = UserData.fromData(userMap);
      variable=final_object;
      //variable=user;
    });
  }

  void NormalSignOut() async {
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
        body:Column( children: <Widget>[
          Container(
            child: Text(
              "Long Press to delete vendor",
              style: TextStyle(color: Colors.pink[600], fontSize: 17),
            ),
          ), 
          VendorsListHostit(),
        ]),
      ),
    );
  }
}
