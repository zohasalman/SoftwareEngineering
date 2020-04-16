import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner:  false,
    home: HomePage(),
  )
);

class HomePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container (
        decoration: BoxDecoration(
          ),
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
                                padding: EdgeInsets.only(bottom: 50, top: 98, left: 80, right: 80),
                                child:Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 22 )) ,))
                            )
                          ] ,)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding:EdgeInsets.only( top: 35, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  alignment: Alignment(1,0),
                  padding: EdgeInsets.only(top: 15, left: 20), 
                  child: InkWell(
                    child: Text('Forgot Password?',
                    style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold, decoration: TextDecoration.underline )
                    )
                  )
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.grey[600]),
                        child: Checkbox(
                          value: false,
                          checkColor: Colors.grey[800],
                          activeColor: Colors.grey[600],
                          onChanged: (value) {},
                          )
                      ),
                      Text('Remember Me?',
                      style: TextStyle(color: Colors.grey[600])
                      ),
                    ],)
                ),
                Container(
                  
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
                    padding: EdgeInsets.only(top: 15, left: 85), 
                    child: Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 22 ))
                ),

                Container(
                  padding: EdgeInsets.only(top: 15, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),
                      TextSpan(text: " Sign Up     ",style: TextStyle(color: Colors.black))
                    ]
                    ))
                  
                ),

                Container(
                  alignment: Alignment(0,0),
                  padding: EdgeInsets.only(top: 15, left: 20), 
                  child: InkWell(
                    child: Text('Or',
                    style: TextStyle(color: Colors.grey[600] )
                    )
                  )
                ),

                Container (
                    child: Transform.translate(
                    offset: Offset(0,10),
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("asset/image/facebook.png")
                            ),
                        ), 
                      ),
                    ),
                  ),

                  Container (
                    child: Transform.translate(
                    offset: Offset(0,15),
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("asset/image/google.png")
                            ),
                        ), 
                      ),
                    ),
                  ),

              ]
            )
          )
        ],
        )  
      )
    ); 
  }
}
