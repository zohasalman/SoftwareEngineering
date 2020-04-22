import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:rateit/auth.dart';
import 'VendorList.dart';
import 'userRedirection.dart';

void main1() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner:  false,
    home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});
  @override 
  FirstScreen createState()=> new FirstScreen(); 
}

final AuthService _auth = AuthService();

class FirstScreen extends State<LoginScreen> {

  String _email = '';
  String _password = '';
  String _errorMessage = ''; 
  bool rememberme=false;

  final _formKey= GlobalKey<FormState>(); 

  void submit() async {
    _formKey.currentState.save();
    dynamic result = await _auth.signInEmailAndPassword(_email, _password); 
    if (result == null){
      setState(() => _errorMessage = 'Invalid email or password combination.');
    }else{
      LoadingScreen();
    }
  }

  void remembermeChange(bool value)=> setState((){
    rememberme=value; 

    if (rememberme)
    {
      //Remember
    }

    else 
    {
      //Forget user
    }

  },
  ); 

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
                TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter an email': null,
                  onSaved: (input)=> _email = input.trim(),
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
                TextFormField(
                  validator: (input)=> input.length<6? 'Please enter a password with at least 6 characters': null,
                  onSaved: (input)=> _password = input.trim(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 7),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> ForgotScreen()),); 
                  },
                  child: new Container(
                  alignment: Alignment(1,0),
                  padding: EdgeInsets.only(top: 15, left: 20), 
                  child: InkWell(
                    child: Text('Forgot Password?',
                    style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold, decoration: TextDecoration.underline )
                    )
                  )
                  ),
                ),
                
                Container(
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.grey[600]),
                        child: Checkbox(
                          value: rememberme,
                          checkColor: Colors.grey[800],
                          activeColor: Colors.grey[600],
                          onChanged: (value) { remembermeChange(value);},
                          )
                      ),
                      Text('Remember Me?',
                      style: TextStyle(color: Colors.grey[600])
                      ),
                    ],)

                ),

                  Container(
                  child: Transform.translate(
                  offset: Offset(0,0),
                  child: InkWell(
                    onTap: submit,
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
                      child: Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 22 ))
                    ),

                  ),
                ),
              ),

              Container(
              child: Transform.translate(
                offset: Offset(0,12),
                child: InkWell(
                  onTap: (){
                  widget.toggleView();
                },
                child: new Container(
                  //padding: EdgeInsets.only(top: 130, left: 20), 
                  child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),
                    TextSpan(text: " Sign Up     ",style: TextStyle(color: Colors.black))
                  ]
                  )),
                ),
                ),
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

class SignScreen extends StatefulWidget {
  
  final Function toggleView;
  SignScreen({this.toggleView});

  @override 
  SecondScreen createState()=> new SecondScreen(); 
}


class SecondScreen extends State<SignScreen> {
  String firstName, lastName, gender, _errorMesage;
  DateTime _dateTime; 
  
  final _formKey= GlobalKey<FormState>(); 

  void submit(){
    _formKey.currentState.save();
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign2Screen(firstName: firstName, lastName: lastName, gender: gender,date: _dateTime)));
  }

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
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),
          
          
          Container(
            padding:EdgeInsets.only( top: 1, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter a valid first name': null, 
                  onSaved: (input)=> firstName = input,
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
                 TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter a valid last name': null, 
                  onSaved: (input)=> lastName=input,
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
                TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter a valid gender' : null, 
                  onSaved: (input)=> gender = input,
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
            padding:EdgeInsets.only( top: 10, left: 20, right: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Text(_dateTime == null ? 'Date of Birth': _dateTime.toString()),
                RaisedButton(
                  child: Text('Pick a date'),
                  onPressed: (){
                    print('here');
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    }); 
                  },
                )
              ],
            )
          ),

          Expanded (
            child: Transform.translate(
            offset: Offset(0,-60),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(
                  icon: new Image.asset("asset/image/icon.png"),
                  onPressed: submit, 
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

class Sign2Screen extends StatefulWidget {

  Sign2Screen({this.firstName, this.lastName, this.gender, this.date});

  final String firstName, lastName, gender;
  final DateTime date;

  @override 
  ThirdScreen createState()=> new ThirdScreen(); 
}


class ThirdScreen extends State<Sign2Screen> {
  String email, password, confirmpassword, _errorMessage; 
  
  final _formKey= GlobalKey<FormState>(); 

  void submit() async {
    _formKey.currentState.save();
    dynamic result = await _auth.registerWithEmailAndPassword(widget.firstName, widget.lastName, widget.gender, widget.date, email, password); 
    if (result == null){
      setState(() => _errorMessage = 'Sign Up failed');
    }else{
      print(result);
      // Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign3Screen()),); 
    }
  }

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
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
              ),
            ),
          ),

         


          
          Container(
            padding:EdgeInsets.only( top: 1, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter an email': null,
                  onSaved: (input)=> email=input,
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
                TextFormField(
                  validator: (input)=> input.length<6? 'Please enter a password with at least 6 characters': null,
                  onSaved: (input)=>password=input,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                  obscureText: true,
                )
                
              ],
            )
          ),


          Container(
            padding:EdgeInsets.only( top: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input)=> input!=password? 'Passwords do not match' : null,
                  onSaved: (input)=>confirmpassword=input,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 19
                    )
                  ),
                  obscureText: true,
                ),
                

              ]
            )
          ),

          Container(
              child: Transform.translate(
              offset: Offset(0,30),
              child: InkWell(
                onTap: submit,
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
          ),

          Container(
          child: Transform.translate(
            offset: Offset(0,100),
            child: InkWell(
              onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),); 
            },
            child: new Container(
              //padding: EdgeInsets.only(top: 130, left: 20), 
              child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "Already have an account?",style: TextStyle(color: Colors.grey[600])),
                TextSpan(text: " Sign In     ",style: TextStyle(color: Colors.black))
              ]
              )),
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

class Sign3Screen extends StatefulWidget {
  @override 
  FourthScreen createState()=> new FourthScreen(); 
}


class FourthScreen extends State<Sign3Screen> {
  
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
            offset: Offset(0,40),
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);  
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
                  padding: EdgeInsets.only(top: 15, left: 85), 
                  child: Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 ))
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

class ForgotScreen extends StatefulWidget {
  @override 
  FifthScreen createState()=> new FifthScreen(); 
}


class FifthScreen extends State<ForgotScreen> {
  String email; 
  
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
                child: new IconButton(icon: new Image.asset("asset/image/arrow.png"),onPressed:()=>Navigator.pop(context) ),
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
                TextFormField(
                  validator: (input)=> input.isEmpty? 'Please enter an email': null,
                  onSaved: (input)=> email=input,
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
              offset: Offset(0,50),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Forgot2Screen()),);  
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
                  child: Text("Send",style: TextStyle(color: Colors.white, fontSize: 22 ))
                ),

              ),
            ),
              
          ),
          
          Container(
          child: Transform.translate(
            offset: Offset(0,100),
            child: InkWell(
              onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> SignScreen()),); 
            },
            child: new Container(
              //padding: EdgeInsets.only(top: 130, left: 20), 
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),
                  TextSpan(text: " Sign Up     ",style: TextStyle(color: Colors.black))
                ]
                )),
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

class Forgot2Screen extends StatefulWidget {
  @override 
  SixthScreen createState()=> new SixthScreen(); 
}



class SixthScreen extends State<Forgot2Screen> {
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
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);  
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
