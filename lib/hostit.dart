import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main.dart';

void main2() => runApp(ScreenQRselect());

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


class ScreenQRselect extends StatelessWidget {
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
                    fit: BoxFit.scaleDown,
                    height: 25,
                    ),
                    onPressed:()=>Navigator.pop(context) ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
              ),
              Center(
                child: 
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(50.0),
                        child: 
                          Container(
                            child: GestureDetector(
                              onTap: () { //Change on Integration
        
                              },
                              child: Container(
                                width: 280.0,
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
                        padding: EdgeInsets.all(50.0),
                        child: 
                          Container(
                            child: GestureDetector(
                              onTap: () { //Change on Integration
                                main();
                              },
                              child: Container(
                                width: 280.0,
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