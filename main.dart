import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner:  false,
    home: FirstScreen()
  )
);


class FirstScreen extends StatelessWidget {
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

                new GestureDetector(
                  onTap:()=>
                    SecondScreen(),
                  
                  child: new Container(
                    padding: EdgeInsets.only(top: 15, left: 20), 
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),
                        TextSpan(text: " Sign Up     ",style: TextStyle(color: Colors.black))

                      ]
                      )),

                  ),
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


class SecondScreen extends StatelessWidget {
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
                                child:Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
              ),
            ),
          ),
          
          
          Container(
            padding:EdgeInsets.only( top: 1, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
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
                    labelText: 'Last Name',
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
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                ),

              ]
            )
          ),

          Container(
            child: Stack(children: <Widget>[
            Positioned(
              child: Container(child: Padding( 
                padding: EdgeInsets.only(top: 20, left: 10, right: 270),
                child:Text("Date Of Birth",style: TextStyle(color: Colors.grey[600], fontSize: 19 )))), 
            ),
          ] ,)),

          
          Container (
            child: Transform.translate(
            offset: Offset(-150,0),
              child:DropdownButton<String>(
                items:[
                  DropdownMenuItem<String>(
                    value: "1",
                    child: Center(child: Text("1"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "2",
                    child: Center(child: Text("2"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "3",
                    child: Center(child: Text("3"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "4",
                    child: Center(child: Text("4"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "5",
                    child: Center(child: Text("5"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "6",
                    child: Center(child: Text("6"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "7",
                    child: Center(child: Text("7"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "8",
                    child: Center(child: Text("8"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "9",
                    child: Center(child: Text("9"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "10",
                    child: Center(child: Text("10"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "11",
                    child: Center(child: Text("11"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "12",
                    child: Center(child: Text("12"),)
                  ),
                ],
                onChanged: (_value){
                },

                hint: Text(
                  "Month"
                ),
              ),
            ), 
          ), 

          Container (
            child: Transform.translate(
            offset: Offset(-80,-48),
              child:DropdownButton<String>(
                items:[
                  DropdownMenuItem<String>(
                    value: "1",
                    child: Center(child: Text("1"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "2",
                    child: Center(child: Text("2"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "3",
                    child: Center(child: Text("3"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "4",
                    child: Center(child: Text("4"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "5",
                    child: Center(child: Text("5"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "6",
                    child: Center(child: Text("6"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "7",
                    child: Center(child: Text("7"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "8",
                    child: Center(child: Text("8"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "9",
                    child: Center(child: Text("9"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "10",
                    child: Center(child: Text("10"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "11",
                    child: Center(child: Text("11"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "12",
                    child: Center(child: Text("12"),)
                  ),
               
                DropdownMenuItem<String>(
                    value: "13",
                    child: Center(child: Text("13"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "14",
                    child: Center(child: Text("14"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "15",
                    child: Center(child: Text("15"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "16",
                    child: Center(child: Text("16"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "17",
                    child: Center(child: Text("17"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "18",
                    child: Center(child: Text("18"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "19",
                    child: Center(child: Text("19"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "20",
                    child: Center(child: Text("20"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "21",
                    child: Center(child: Text("21"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "22",
                    child: Center(child: Text("22"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "23",
                    child: Center(child: Text("23"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "24",
                    child: Center(child: Text("24"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "25",
                    child: Center(child: Text("25"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "26",
                    child: Center(child: Text("26"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "27",
                    child: Center(child: Text("27"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "28",
                    child: Center(child: Text("28"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "29",
                    child: Center(child: Text("27"),)
                  ),

                  DropdownMenuItem<String>(
                    value: "30",
                    child: Center(child: Text("28"),)
                  ),
                ],
                onChanged: (_value){
                },


                hint: Text(
                  "Day"
                ),
              ),
            ), 
          ), 

          Container (
            child: Transform.translate(
            offset: Offset(-20,-95),
              child:DropdownButton<String>(
                items:[
                  DropdownMenuItem<String>(
                  value: "1950",
                  child: Center (child: Text("1950"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1951",
                  child: Center (child: Text("1951"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1952",
                  child: Center (child: Text("1952"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1953",
                  child: Center (child: Text("1953"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1954",
                  child: Center (child: Text("1954"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1955",
                  child: Center (child: Text("1955"),),
                  ),
                  DropdownMenuItem<String>(
                  value: "1956",
                  child: Center (child: Text("1956"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1957",
                  child: Center (child: Text("1957"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1958",
                  child: Center (child: Text("1958"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1959",
                  child: Center (child: Text("1959"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1960",
                  child: Center (child: Text("1960"),)
                  ),
                  DropdownMenuItem<String>(
                  value: "1961",
                  child: Center (child: Text("1961"),)
                  ),
  
                ],
                onChanged: (_value){
                },


                hint: Text(
                  "Year"
                ),
              ),
            ), 
          ), 

          Container (
            child: Transform.translate(
            offset: Offset(0,-50),
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/icon.png")
                    ),
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


class ThirdScreen extends StatelessWidget {
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
                                child:Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
              ),
            ),
          ),
          
          
          Container(
            padding:EdgeInsets.only( top: 1, left: 20, right: 20),
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
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                ),

              ]
            )
          ),

          Container(
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
                padding: EdgeInsets.only(top: 15, left: 85), 
                child: Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 ))
              ),

            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 75, left: 20), 
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "Already have an account?",style: TextStyle(color: Colors.grey[600])),
                TextSpan(text: " Sign In     ",style: TextStyle(color: Colors.black))
              ]
              )),

          ),
          
        ],
        )  
      )
    ); 
  }
}


class FourthScreen extends StatelessWidget {
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
                                child:Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
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
            offset: Offset(-120,0),
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
                    TextSpan(text: "Registeration Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                  
                  ]
                  )),

              ),
            ),
           ),

          Container(
            child: Transform.translate(
            offset: Offset(0,-40),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "An account registration request has been sent to your email. ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "Click the link in the email to validate your email address.",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "Questions?",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "Contact us on ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "help.rateit@gmail.com ",style: TextStyle(color: Colors.pink[800], fontSize: 17))
                  ]
                  )),

              ),
            ),
          ),

          
         
          Container(
            child: Transform.translate(
            offset: Offset(0,20),
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

        ],
        )  
      )
    ); 
  }
}

class FifthScreen extends StatelessWidget {
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
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text("Forgot password",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
              ),
            ),
          ),

          
          Container(
            child: Transform.translate(
            offset: Offset(0,10),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "We'll send instructions on how to reset your password to the email address you have registered with us ",style: TextStyle(color: Colors.black, fontSize: 17)),
                   
                  ]
                  )),

              ),
            ),
          ),

           Container(
            padding:EdgeInsets.only( top: 30, left: 20, right: 20),
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
            child: Transform.translate(
            offset: Offset(0,100),
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
                child: Text("Send",style: TextStyle(color: Colors.white, fontSize: 22 ))
              ),

            ),
          ),

           Container(
              padding: EdgeInsets.only(top: 130, left: 20), 
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),
                  TextSpan(text: " Sign Up     ",style: TextStyle(color: Colors.black))
                ]
                )),

            ),

        ],
        )  
      )
    ); 
  }
}

class SixthScreen extends StatelessWidget {
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
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text("Forgot password",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
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
            offset: Offset(-120,0),
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
                    TextSpan(text: "Recovery Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                  
                  ]
                  )),

              ),
            ),
           ),

          Container(
            child: Transform.translate(
            offset: Offset(0,-40),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "An email has been successfully sent to you with your login credentials.",style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextSpan(text: "Questions?",style: TextStyle(color: Colors.black, fontSize: 17)),
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

        ],
        )  
      )
    ); 
  }
}

class RateItFirstScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container (
        decoration: BoxDecoration(
          ),
        child: Column(children: <Widget>[
          Expanded (
            child: Transform.scale(
            scale: 1.2,
              child: Transform.translate(
              offset: Offset(0,-50),
                child: Container(
                  height: 2000,
                  width: 2000,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("asset/image/rateit.png")
                      ),
                  ), 
                ),
              ),
            ),
          ),

          Expanded(
            child: Transform.rotate(
            angle: math.pi,
              child: Transform.scale(
              scale: 1.2,
                child: Transform.translate(
                offset: Offset(0,-150),
                  child: Container(
                    height: 2000,
                    width: 2000,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("asset/image/rateit.png")
                        ),
                    ), 
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: Transform.translate(
            offset: Offset(0,-300),
              child: Container(
                padding: EdgeInsets.only(top: 0, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Welcome to K-EAT",style: TextStyle(color: Colors.black, fontSize: 35)),
                    
                  ]
                  )),

              ),
            ),
          ),

          
          Container(
            child: Transform.translate(
            offset: Offset(0,-260),
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
                padding: EdgeInsets.only(top: 15, left: 80), 
                child: Text("Continue",style: TextStyle(color: Colors.white, fontSize: 22 ))
              ),

            ),
          ),
          
        ],
        )  
      )
    ); 
  }
}

class RateItSecondScreen extends StatelessWidget {
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
                                padding: EdgeInsets.only(bottom: 50, top: 78, left: 80, right: 80),
                                child:Text("K-EAT",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
            offset: Offset(180,-140),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/menu.png")
                    ),
                ), 
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(180,-140),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/search.png")
                    ),
                ), 
              ),
            ),
          ),

          Container (
            child: Transform.translate(
            offset: Offset(140,250),
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/camera.png")
                    ),
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

class RateItFourthScreen extends StatelessWidget {
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
                                padding: EdgeInsets.only(bottom: 50, top: 85, left: 80, right: 80),
                                child:Text("Mcdonalds",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/arrow.png")
                    ),
                ), 
              ),
            ),
          ),
          Expanded (
            child: Transform.scale(
            scale: 1.5,
              child: Transform.translate(
              offset: Offset(0,-90),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("asset/image/mcdonalds.png")
                      ),
                  ), 
                ),
              ),
            ),
          ),

         

          Container (
            child: Transform.translate(
            offset: Offset(140,250),
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/camera.png")
                    ),
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