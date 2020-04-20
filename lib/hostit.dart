import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'login.dart';
import 'main.dart';


import 'package:firebase_database/firebase_database.dart';

import 'VendorList.dart';

void main2() => runApp(App());

String number="8"; 
List<int> no=[2,3,4,5,6,7,8,9]; 




class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner:  false,
    home: Maps(),
    );
  }
}

class AddEvent extends StatefulWidget {
  @override 
  Screen36 createState()=> new Screen36(); 
}

class Screen36 extends State<AddEvent> {
  String name, location;
  var logo, photo;  
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Add Event",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-40),
              child: Container(
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
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-40),
              child: Container(
                padding:EdgeInsets.only( top: 5, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input)=> input.isEmpty? 'Please enter a valid location': null,
                      onSaved: (input)=> location=input,
                      decoration: InputDecoration(
                        labelText: 'Location',
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
          ),
          

          

          Container (
            child: Transform.translate(
            offset: Offset(160,-90),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/location.png"),onPressed:()=>{} ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-80),
              child: Container(
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
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-70),
              child: Container(
                padding:EdgeInsets.only( top: 0, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      
                      validator: (input)=> input.isEmpty? 'Please enter a logo': null,
                      onSaved: (input)=> logo=input,
                      decoration: InputDecoration(
                        labelText: 'Upload a logo of your event',
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
          ),

          Container (
            child: Transform.translate(
            offset: Offset(162,-115),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
              ),
            ),
          ),
          
          Container(
            child: Transform.translate(
            offset: Offset(0,-115),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    
                    TextSpan(text: "*Please make sure the file is a png or jpeg file and of ratio 4:3 ",style: TextStyle(color: Colors.red, fontSize: 15))
                  ]
                  )),

              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(0,-120),
              child: Container(
                padding:EdgeInsets.only( top: 0, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input)=> input.isEmpty? 'Please enter a photo': null,
                      onSaved: (input)=> photo=input,
                      decoration: InputDecoration(
                        labelText: 'Upload a photo of your event',
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
          ),

          Container (
            child: Transform.translate(
            offset: Offset(165,-165),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/upload.png"),onPressed:()=>{} ),
              ),
            ),
          ),
          
          Container(
            child: Transform.translate(
            offset: Offset(0,-165),
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
            offset: Offset(0,-175),
              child: Container(
                height: 70,
                width: 160,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

          
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

  @override 
  Widget build(BuildContext context){
    return Scaffold(
    
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text(eventName,style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

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

class AddVendor extends StatefulWidget {
  @override 
  Screen41 createState()=> new Screen41(); 
}

class Screen41 extends State<AddVendor> {

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
     
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Add Vendors",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

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

         
         
        ],
        )  
      )
    ); 
  }
}



class AddVen extends StatefulWidget {
  @override 
  Screen44 createState()=> new Screen44(); 
}

class Screen44 extends State<AddVen> {
  String name,email, stallid,item;
  bool value=false; 
  var logo, mlogo;  
  bool check=false; 
  var nu; 

  var n=int.parse(number); 
  List<Widget> menu=[], menu2=[]; 
  
  int count=1; 
 
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  
 

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

  void add3(){
    menu2=List.from(menu2)..add(
     

    Container(
    child: Transform.translate(
    offset: Offset(0,-50),
    child: new Container(
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
    ),),
      
      );

      setState(() {
        
      });

  }

   void add4(){
    menu2=List.from(menu2)..add(
     
      Container(
        child: Transform.translate(
        offset: Offset(0,-50),
        child: new Container(
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
        )
      ),
        ),),
      
      );

      setState(() {
        
      });

  }

   void add5(){
    menu2=List.from(menu2)..add(
     
      Container(
          child: Transform.translate(
          offset: Offset(0,-50),
          child: new Container(
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
          ),),

      
      );

      setState(() {
        
      });

  }
 
   void add6(){
    menu2=List.from(menu2)..add(
     

    Container(
      child: Transform.translate(
      offset: Offset(0,-50),
      child: new Container(
      padding:EdgeInsets.only( top: 0, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (input)=> input.isEmpty? 'Please enter a logo': null,
            onSaved: (input)=> logo=input,
            decoration: InputDecoration(
              labelText: 'Upload a logo of the vendor',
              labelStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 19
              )
            ),
          )
        ],
      )
    ),
      ),),
      
      );

      setState(() {
        
      });

  }

   void add7(){
    menu2=List.from(menu2)..add(
     
      
      Container (
      child: Transform.translate(
      offset: Offset(162,-100),
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

   void add8(){
    menu2=List.from(menu2)..add(
     
      Container(
        child: Transform.translate(
        offset: Offset(0,-95),
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

      
      );

      setState(() {
        
      });

  }

   void add9(){
    menu2=List.from(menu2)..add(
     
      Container(
      child: Transform.translate(
      offset: Offset(0,-100),
      child: new Container(
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
      ),),
      
      );

      setState(() {
        
      });

  }

  @override 
  Widget build(BuildContext context){
    
    if (!check)
    {
       for (var i=0; i<n; i++)
      {
        
        add2(i);
        add3(); 
        add4(); 
        add5(); 
        add6(); 
        add7(); 
        add8(); 
        add9(); 
        
      }
      check=true; 

    }
   
    
    
    return Scaffold(
     
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Add Vendors",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> AddVen()),) ),
              ),
            ),
          ),

          
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Add Menu",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

          
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Edit Vendors",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>{}),
              ),
            ),
          ),

          
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Add Menu",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

          
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
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 88, left: 80, right: 80),
                                child:Text("Edit Event",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>{}),
              ),
            ),
          ),

          
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
 final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  @override 

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text(event,style: TextStyle(color: Colors.white, fontSize: 22 )))), 
                            ),
                          ] ,)
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

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
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(0,60),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text(event ,style: TextStyle(color: Colors.white, fontSize: 22 )))), 
                            ),
                          ] ,)
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

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

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(10,70),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text("Vendor" ,style: TextStyle(color: Colors.white, fontSize: 22 )))), 
                            ),
                          ] ,)
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),

          ),

          Container(
            child: Transform.translate(
            offset: Offset(170,-220),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/menu.png"),
                    ),
                ),
          ), 
              ),
          ),
          

          Container(
            child: Transform.translate(
            offset: Offset(170,-278),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/search.png"),
                    ),
                ),
          ), 
              ),
          ),
          

      Container(
        child: Transform.translate(
        offset: Offset(0,-278),
      
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
    ));
  }
}

class ViewVendor2 extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return _ViewVendor2();
  }
}

class _ViewVendor2 extends State<ViewVendor2> {
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

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      key: _formKey,
        child: Column(children: <Widget>[
          Container(
            child: Transform.scale(
            scale: 1.5,  
              child: Transform.rotate(
                angle: -math.pi/18,
                child: Transform.translate(
                  offset: Offset(0,-60),
                  child: Container (
                    height: 175,
                    width: 2000,
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
                        image: AssetImage("asset/image/Chat.png")
                        ),
                    ),
                    child: Transform.translate(
                      offset: Offset(10,70),
                      child: Transform.rotate(
                        angle: math.pi/18,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(child: Padding( 
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text("Delete Vendor" ,style: TextStyle(color: Colors.white, fontSize: 22 )))), 
                            ),
                          ] ,)
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
          Container (
            child: Transform.translate(
            offset: Offset(-180,-140),
              child: Container(
                height: 50,
                width: 250,
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),

          ),

          Container(
            child: Transform.translate(
            offset: Offset(170,-220),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/menu.png"),
                    ),
                ),
          ), 
              ),
          ),
          

          Container(
            child: Transform.translate(
            offset: Offset(170,-278),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/search.png"),
                    ),
                ),
          ), 
              ),
          ),

          Container(
            child: Transform.translate(
            offset: Offset(-30,-270),
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
        offset: Offset(0,-278),
      
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
    ));
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
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Transform.scale(
                scale: 1.5,  
                  child: Transform.rotate(
                    angle: -math.pi/18,
                    child: Transform.translate(
                      offset: Offset(0,-60),
                      child: Container (
                        height: 175,
                        width: 2000,
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
                            image: AssetImage("asset/image/Chat.png")
                            ),
                        ),
                        child: Transform.translate(
                          offset: Offset(0,75),
                          child: Transform.rotate(
                            angle: math.pi/18,
                              child: Stack(children: <Widget>[
                                Positioned(
                                  child: Container(child: Padding( 
                                    padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                    child:Text("QR Codes",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
                                ),
                              ] ,)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container (
                child: Transform.translate(
                offset: Offset(-180,-140),
                  child: Container(
                    height: 30,
                    width: 50,
                    child: new IconButton(icon: new Image.asset("asset/image/arrow.png",
                    //fit: BoxFit.scaleDown,
                    //height: 25,
                    ),
                    onPressed:()=>Navigator.pop(context) ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
              ),
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
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);
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
  @override
  MapsFunc createState() => MapsFunc();
}

class MapsFunc extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Marker marker=Marker(
    markerId: MarkerId("1"),
    draggable: true
  ); //storing position coordinates in the variable
  Set<Marker> markerSet={};
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.red[700],
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
