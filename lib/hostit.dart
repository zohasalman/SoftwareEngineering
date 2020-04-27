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
  var i =0.0;
  String name;
  String logo, photo;  
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
                        child: Text('Add Event',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
                      validator: (input)=> input.isEmpty? 'Please enter a name': null,
                      onSaved: (input)=> name=input,
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
                      //validator: (input)=> input.isEmpty? 'Please enter a valid location': null,
                      //onSaved: (input)=> location=input,
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
                    onPressed: () {//Maps();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> Maps()),);
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
                  onSaved: (input)=> number=input,
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
                      onSaved: (input)=> logo=input,
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
                  onSaved: (input)=> photo=input,
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
                    onPressed: () {
                      GeoPoint eventLocation = GeoPoint(coord.latitude, coord.longitude);
                      String uid = Provider.of<String>(context);
                      var newEvent = new Event(uid:uid, eventID:randomAlphaNumeric(10), invitecode:randomAlpha(6), location1:eventLocation, name:name, logo:logo, coverimage:photo);






                      //Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVendor()),);   //Modify here to upload Event Data and then move on
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
  @override 
  Screen39 createState()=> new Screen39(); 
}

class Screen39 extends State<EventMenu> {
  String eventName= "Karachi Eat"; 
   
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  var scaffoldKey=GlobalKey<ScaffoldState>();
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
        child: Column(children: <Widget>[
           Container(
            child: Transform.translate(
            offset: Offset(0,-60),
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
          ),

          Container(
            child: Transform.translate(
            offset: Offset(0,-40),
            child: Padding(
              padding:EdgeInsets.only(top: 0, left: 0), 
              child: Container(
                height: 1, 
                width: 350, 
                color: Colors.black,),
              ),
            ),
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,-10),
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
          ),

          
          Container(
              child: Transform.translate(
              offset: Offset(0,10),
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
                  padding: EdgeInsets.only(top: 15, left: 90), 
                  child: Text("Download QR codes",style: TextStyle(color: Colors.white, fontSize: 18 ))
                ),

              ),
            ),
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,30),
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
                  padding: EdgeInsets.only(top: 15, left: 115), 
                  child: Text("Email QR codes",style: TextStyle(color: Colors.white, fontSize: 18 ))
                ),

              ),
            ),
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,50),
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
                  padding: EdgeInsets.only(top: 15, left: 125), 
                  child: Text("Add Vendors",style: TextStyle(color: Colors.white, fontSize: 18 ))
                ),

              ),
            ),
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,70),
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
                  padding: EdgeInsets.only(top: 15, left: 125), 
                  child: Text("Edit a Vendor",style: TextStyle(color: Colors.white, fontSize: 18 ))
                ),

              ),
            ),
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,90),
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
                  padding: EdgeInsets.only(top: 15, left: 130), 
                  child: Text("Edit Event",style: TextStyle(color: Colors.white, fontSize: 18 ))
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

class AddVendorQty extends StatefulWidget {
  @override 
  Screen41 createState()=> new Screen41(); 
}

class Screen41 extends State<AddVendorQty> {

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
            child: Transform.translate(
            offset: Offset(0,0),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "How many vendors would you like to add?",style: TextStyle(color: Colors.black, fontSize: 20))
                  ]
                  )),

              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,40),
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
                child: Transform.translate(
                offset: Offset(70,0),
                child:DropdownButton<String>(
                
                value:number, 
                
                
                items:n, 
                
                onChanged: (value){
                  number=value; 
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
            child: number!="Custom"? Container(): Container(
              padding:EdgeInsets.only( top: 80, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input)=> input.isEmpty? 'Please enter a number': null,
                    onSaved: (input)=> number=input,
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
            child: Transform.translate(
            offset: Offset(0,-50),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{} ),
              ),
            ),
          ),         
        ],),  
      )
    ); 
  }
}



class AddVendor extends StatefulWidget {
  @override 
  AddVendorState createState()=> new AddVendorState(); 
}

class AddVendorState extends State<AddVendor> {
  String name,email, stallid,item;
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  var nu; 
  var n=int.parse(number); 
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
                    text: "Vendor $i",
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

  void add3(){
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
                onSaved: (input)=> name=input,
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

  void add4(){
    menu2=List.from(menu2)..add(
     
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 0.90,
        child: new Container(
          width: MediaQuery.of(context).copyWith().size.width * 0.90,
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input)=> input.isEmpty? 'Please enter an email': null,
                onSaved: (input)=> email=input,
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

  void add5(){
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
                onSaved: (input)=> stallid=input,
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
 
  void add6(){
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
                    onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=> Add()),);},
                  ),
                ),
              )
            ],),
          ),
    );

    setState(() {
      
    });

  }

  // void add7(){
  //   menu2=List.from(menu2)..add(   
  //     Container (
  //       //width: MediaQuery.of(context).copyWith().size.width * 0.90,
  //       child: Container(
  //         //width: MediaQuery.of(context).copyWith().size.width * 0.90,
  //         height: 50,
  //         width: 250,
  //         child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
  //       ),
  //     ),
  //   );

  //   setState(() {
      
  //   });
  // }

   void add8(){
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

   void add9(){
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
                onSaved: (input)=> no=List.from(no)..add(nu),
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
    
    if (!check)
    {
      Padding(padding: EdgeInsets.only(top: 15));
       for (var i=1; i<n; i++)
      {
        
        add2(i);
        add3(); 
        add4(); 
        add5(); 
        add6(); 
        add8(); 
        add9(); 
        
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
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Add()),);   //Modify here to upload Event Data and then move on
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
  @override 
  Screen45 createState()=> new Screen45(); 
}

class Screen45 extends State<Add> {
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
       )

    
      
      );

      setState(() {
        
      });

  }

    void addvalue2(){
    menu2=List.from(menu2)..add(
      Container(
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
      ),),

     
      
      );

      setState(() {
        
      });

  }

  void addvalue3(){
    menu2=List.from(menu2)..add(
     
      Container (
          child: Container(
            height: 50,
            width: 250,
            child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
        ),
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
          //padding: EdgeInsets.only(top: 130, left: 20), 
          child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(text: "Vendor $i",style: TextStyle(color: Colors.black, fontSize: 22))
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

    
    
    {
       if (!check)
      {
        for (var i=0; i<n; i++)
        {
          add2(i+1); 
          //print(no[i]); 
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
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> QRselection()),),
                } ),
              ),
            ),
          ),
      


          
        ],
        )  
      )

      
    ); 
  }
}

class EditVen extends StatefulWidget {
  @override 
  Screen46 createState()=> new Screen46(); 
}

class Screen46 extends State<EditVen> {
  String name,email, stallid,item;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 
  String inputname="Mcdonalds", inputemail="zohasalman123@gmail.com", inputstallid="112344", inputimage="mcdonalds.png", inputmenunumber="8";
  
  bool value=false; 

  var logo, mlogo;  
  bool check=false; 
  var nu; 

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
            child: Column(
            children: menu2),
          ),

                
          Container(
          child: Transform.translate(
          offset: Offset(0,-50),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: dcontroller,
                validator: (input)=> input.isEmpty? 'Please enter a name': null,
                onSaved: (input)=> name=input,
                decoration: InputDecoration(
                  hintText: inputname,
                  suffixIcon: IconButton(
                    onPressed: ()=> {
                      setState((){
                        dcontroller.clear();
                      }),
                    },
                    icon: Icon(Icons.clear), 
                  )

                ),
              )
            ],
          )
          ),
          ),),

          Container(
            child: Transform.translate(
            offset: Offset(0,-30),
            child: new Container(
            padding:EdgeInsets.only( top: 0, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: dcontroller2,
                  validator: (input)=> input.isEmpty? 'Please enter an email': null,
                  onSaved: (input)=> email=input,
                  decoration: InputDecoration(
                    hintText: inputemail,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller2.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
              ],
            )
          ),
            ),),

           Container(
          child: Transform.translate(
          offset: Offset(0,-10),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: dcontroller3,
                  validator: (input)=> input.isEmpty? 'Please enter a stall ID': null,
                  onSaved: (input)=> stallid=input,
                  decoration: InputDecoration(
                    hintText: inputstallid,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller3.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
                
            
            ],
          )
        ),
          ),),

        Container(
          child: Transform.translate(
          offset: Offset(0,10),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: dcontroller4,
                  validator: (input)=> input.isEmpty? 'Please enter a logo': null,
                  onSaved: (input)=>  logo=input,
                  decoration: InputDecoration(
                    hintText: inputimage,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller4.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
             
            ],
          )
        ),
          ),),

        Container (
          child: Transform.translate(
          offset: Offset(162,-40),
            child: Container(
              height: 50,
              width: 250,
              child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
            ),
          ),
        ),
          
        Container(
        child: Transform.translate(
          offset: Offset(0,-35),
            child: Container(
              padding: EdgeInsets.only(top: 0, left: 20), 
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  
                  TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
                ]
                )),

            ),
          ),
        ),

        Container(
        child: Transform.translate(
        offset: Offset(0,-25),
        child: new Container(
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(

              keyboardType: TextInputType.number,
              controller: dcontroller5,
                  validator: (input)=> input.isEmpty? 'Please enter a number': null,
                  onSaved: (input)=>  no=List.from(no)..add(nu),
                  decoration: InputDecoration(
                    hintText: inputmenunumber,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller5.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
          
          ],
        )
      ),
        ),),


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
          //print(no[i]); 
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
  @override 
  Screen50 createState()=> new Screen50(); 
}

class Screen50 extends State<EditEvent> {
  String name, add, vendor, image, pic;
  final dcontroller=new TextEditingController(); 
  final dcontroller2=new TextEditingController(); 
  final dcontroller3=new TextEditingController(); 
  final dcontroller4=new TextEditingController(); 
  final dcontroller5=new TextEditingController(); 
  String input="Karachi Eat", inputadd="Block 3 Clifton, Karachi", inputvendors="9", inputimag="logo.png", inputmepic="Cover.jpg";
  
  bool value=false; 

  var logo, mlogo;  
  bool check=false; 
  var nu; 

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

                
          Container(
          child: Transform.translate(
          offset: Offset(0,-50),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: dcontroller,
                validator: (input)=> input.isEmpty? 'Please enter a name': null,
                onSaved: (input)=> name=input,
                decoration: InputDecoration(
                  hintText: input,
                  suffixIcon: IconButton(
                    onPressed: ()=> {
                      setState((){
                        dcontroller.clear();
                      }),
                    },
                    icon: Icon(Icons.clear), 
                  )

                ),
              )
            ],
          )
          ),
          ),),


          Container(
            child: Transform.translate(
            offset: Offset(0,-30),
            child: new Container(
            padding:EdgeInsets.only( top: 0, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: dcontroller2,
                  validator: (input)=> input.isEmpty? 'Please enter an address': null,
                  onSaved: (input)=> add=input,
                  decoration: InputDecoration(
                    hintText: inputadd,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller2.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
              ],
            )
          ),
            ),),

          

           Container(
          child: Transform.translate(
          offset: Offset(0,-10),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: dcontroller3,
                  validator: (input)=> input.isEmpty? 'Please enter the number of vendors': null,
                  onSaved: (input)=>  vendor=input,
                  decoration: InputDecoration(
                    hintText: inputvendors,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller3.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
                
            
            ],
          )
        ),
          ),),

       

        Container(
          child: Transform.translate(
          offset: Offset(0,10),
          child: new Container(
          padding:EdgeInsets.only( top: 0, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: dcontroller4,
                  validator: (input)=> input.isEmpty? 'Please enter an image of event': null,
                  onSaved: (input)=>  image=input,
                  decoration: InputDecoration(
                    hintText: inputimag,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller4.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
             
            ],
          )
        ),
          ),),

        Container (
          child: Transform.translate(
          offset: Offset(162,-40),
            child: Container(
              height: 50,
              width: 250,
              child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
            ),
          ),
        ),
          
        Container(
        child: Transform.translate(
          offset: Offset(0,-35),
            child: Container(
              padding: EdgeInsets.only(top: 0, left: 20), 
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  
                  TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3",style: TextStyle(color: Colors.red, fontSize: 15))
                ]
                )),

            ),
          ),
        ),


        Container(
        child: Transform.translate(
        offset: Offset(0,-25),
        child: new Container(
        padding:EdgeInsets.only( top: 0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextFormField(

              keyboardType: TextInputType.number,
              controller: dcontroller5,
                  validator: (input)=> input.isEmpty? 'Please insert a picture of the event': null,
                  onSaved: (input)=>  pic=input,
                  decoration: InputDecoration(
                    hintText: inputmepic,
                    suffixIcon: IconButton(
                      onPressed: ()=> {
                        setState((){
                          dcontroller5.clear();
                        }),
                      },
                      icon: Icon(Icons.clear), 
                    )

                  ),
                )
          
          ],
        )
      ),
        ),),

          Container (
          child: Transform.translate(
          offset: Offset(162,-75),
            child: Container(
              height: 50,
              width: 250,
              child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
            ),
          ),
        ),

        Container(
        child: Transform.translate(
          offset: Offset(0,-70),
            child: Container(
              padding: EdgeInsets.only(top: 0, left: 20), 
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  
                  TextSpan(text: "*Please make sure the file is a png or jpeg file and of size 100x100",style: TextStyle(color: Colors.red, fontSize: 15))
                ]
                )),

            ),
          ),
        ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-40),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>{} ),
              ),
            ),
          ),

          
          Container (
            child: Transform.translate(
            offset: Offset(160,-495),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/location.png"),onPressed:()=>{} ),
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

class ViewVendor extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return _ViewVendor();
  }
}

class _ViewVendor extends State<ViewVendor> {
  List<VendorList> vendors = [
    VendorList(vendorname: 'Cloud Naan', flag: 'cloudnaan.png'),
    VendorList(vendorname: 'KFC', flag: 'kfc.png'),
    VendorList(vendorname: 'McDonalds', flag: 'mcdonalds.png'),
    VendorList(vendorname: 'No Lies Fries', flag: 'noliesfries.png'),
    VendorList(vendorname: 'Caffe Parha', flag: 'caffeparha.png'),
    VendorList(vendorname: 'DOH', flag: 'doh.png'),
    VendorList(vendorname: 'Carbie', flag: 'carbie.png'),
    VendorList(vendorname: 'The Story', flag: 'thestory.png'),
    VendorList(vendorname: 'Meet the Cheese', flag: 'meetthecheese.png'),
    
  ];
   var scaffoldKey=GlobalKey<ScaffoldState>();

  
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
                        child: Text('Vendor',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
                      padding: EdgeInsets.only(right: 20.0, left: 10.0),
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
        offset: Offset(0,140),
      
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vendors.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onLongPress: ()=> {},
              onTap: () {
                debugPrint('${vendors[index].vendorname} is pressed!');
              },
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

class QRselection extends StatefulWidget {
  @override
  ScreenQRselect createState() => new ScreenQRselect();
}

class ScreenQRselect extends State<QRselection> {
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
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> InviteScreen()),);
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
                      
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> AddEvent(coord: coord)),);
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
                  print(coord.latitude);
                  print(coord.longitude);
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      print('OOOOOOOOOOOOOOOOO');
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

class CreateEvent extends StatefulWidget {

  Event data;
  int numVen;
  CreateEvent({this.data,this.numVen});
  @override
  CreateEventEntry createState() => CreateEventEntry();
}

class CreateEventEntry extends State<CreateEvent> {
  Event data;
  int numVen;
  CreateEventEntry({this.data,this.numVen});
  @override
  Widget build(BuildContext context) {
    String done = FirestoreService().addEventPromise(data).toString();//addEventPromise(data); 
    
    if (done == ''){
      return LoadingScreen();
    }
    else if(done == 'Error'){  //Failure to fetch Data, Firebase Error. 
    //TO DO Can be due to internet connection or wrong input, Display a Error Screen with firebase error stated in 
      return ErrorSignIn();
    }
    else{
      return AddVendor();
    }
  }
 }
