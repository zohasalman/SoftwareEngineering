import 'package:flutter/material.dart';
//import 'dart:math' as math;
import 'package:rateit/auth.dart';
//import 'VendorList.dart';
import 'Clipshape.dart';
import 'userRedirection.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main1() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    theme: new ThemeData(
      primaryColor: Color(0xFFAC0D57),
      splashColor: Color(0xFFFC4A1F),
 

    ),
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
  bool hasInfo = false;

  final _formKey= GlobalKey<FormState>(); 

  
  void submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _errorMessage = '');
    _formKey.currentState.save();
    prefs.setBool('rememberMe', rememberme);
    if (rememberme == true){
      prefs.setString('email', _email);
      prefs.setString('password', _password);
    }
    dynamic result = await _auth.signInEmailAndPassword(_email, _password); 
    if (result == null){
      setState(() => _errorMessage = 'Invalid email or password combination.');
    }else{
      Redirection();
    }
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('rememberMe') == true){
      final String emailId = prefs.getString('email');
      final String pw = prefs.getString('password');
      _email = emailId;
      _password = pw;
      hasInfo = true;
      print('rememberMe:');
      print(hasInfo);
      print(emailId);
      print(pw);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogIn();
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

              AppBar(
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0, left: 10),
                      child: Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
                ),
              ),
              ),
            ],
          ),
          clipper: ClipShape(),
        )
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  
                  SafeArea(
                    child: Padding(
                    padding:EdgeInsets.only( top: 30, left: 20, right: 20), 
                    child:TextFormField(
                    initialValue: hasInfo? _email: null,
                    validator: (input)=> input.isEmpty? null : null,
                    onSaved: (input)=> _email = input.trim(),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(  
                        color: Colors.grey[600],
                        fontSize: 19
                      )
                    ),
                    )
                  ),),
                ],
              )
            ),

            SafeArea(
            
              child: Column(
                children: <Widget>[
                  SafeArea(
                    
                    child: Padding(
                    padding:EdgeInsets.only( top: 0, left: 20, right: 20), 
                    child:TextFormField(
                    initialValue: hasInfo? _password: null,
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
                  ),),),

                  SafeArea(
                      child: _errorMessage != "Invalid email or password combination."? Container() : Container(
                        
                        padding:EdgeInsets.only( top: 5), 
                        child: Column(
                          children: <Widget>[
                            
                            Container(
                              alignment: Alignment(-0.8,-0.9),
                                child: Text(_errorMessage,
                                style: TextStyle(color: Colors.red)
                                ),
                            ),
                          ],
                        )                        
                      ),
                    ),

                  SizedBox(height: 7),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> ForgotScreen()),); 
                    },
                    child: new Container(
                  
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text('Forgot Password? ',
                      style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold, decoration: TextDecoration.underline )
                    
                      )
                      
                    )
                    ),
                  ),
                  
                  Container(
                    height:20,
                    child: Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.grey[600]),
                          child: Checkbox(
                            value: rememberme,
                            checkColor: Colors.grey[800],
                            activeColor: Colors.grey[600],
                            onChanged: (value) => rememberme = value,
                            )
                        ),
                        Text('Remember Me?',
                        style: TextStyle(color: Colors.grey[600])
                        ),
                      ],)

                  ),

                    SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top:40),
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
                  alignment: Alignment(0,0),
                  padding: EdgeInsets.only(top: 20, left: 0),
                  child: InkWell(
                    onTap: (){
                      _formKey.currentState.reset(); 
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> SignScreen()),); 
                    //widget.toggleView();
                  },
                  child: new SafeArea(
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
                
                  Container(
                    alignment: Alignment(0,0),
                    padding: EdgeInsets.only(top: 5, left: 20), 
                    child: InkWell(
                      child: Text('Or',
                      style: TextStyle(color: Colors.grey[600] )
                      )
                    )
                  ),

                  Container(
                    alignment: Alignment(0,0),
                    padding: EdgeInsets.only(top: 20),
                  ),
                

                  Center (
                    //alignment: Alignment.bottomCenter,
                    child: Container(
                    height: 50,
                    width: 250,
                    
                    decoration: BoxDecoration(
                      
                      image: DecorationImage(
                        image: AssetImage("asset/image/facebook.png")
                        ),
                    ),
                    child: InkWell(
                    onTap: () {
                      _auth.signInWithFacebook();
                    },
                    ), 
                        
                  ),),

                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("asset/image/google.png")
                        ),
                    ),
                    child: InkWell(
                    onTap: () {
                      _auth.signInWithGoogle();
                    },
                    ), 
                  ),
                  
                ]
              )
            )
          ],
          )  
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
  String firstName='', lastName='', gender; 
  bool error1=true, error2=true; 

  DateTime _dateTime; 

  bool validate=false; 
  final _formKey= GlobalKey<FormState>(); 

  void submit(){
    setState(() => validate=true);
    _formKey.currentState.save();
    if (!error1 && !error2 && (firstName!='') && (lastName!='')) {
      Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign2Screen(firstName: firstName, lastName: lastName, gender: gender,date: _dateTime)));
    }
    
  }

  List<DropdownMenuItem<String>> n=[];
  void loadData(){
    n=[];
    n.add(new DropdownMenuItem(
      child: new Text('Male'),
      value: 'Male')
    ); 
    n.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 'Female')
    ); 
     n.add(new DropdownMenuItem(
      child: new Text('Other'),
      value: 'Other')
    ); 
   
  }

  @override 
  Widget build(BuildContext context){
    loadData(); 
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                      child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
            Container(
              padding:EdgeInsets.only( top: 1, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input.isEmpty? 'Please fill out this field': null, 
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
                    validator: (input)=> input.isEmpty? 'Please fill out this field': null, 
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
            SafeArea(
              child:  Container(
              padding:EdgeInsets.only( top: 10, left: 20, right: 20),
              child: SafeArea(
              child: Row(
              children: <Widget>[
                Text('Gender',style: TextStyle(color: Colors.grey[600], fontSize: 19)),
                Container(
                padding:EdgeInsets.only(left:80 ),
                child: SafeArea(
                child: DropdownButton<String>(
                  value:gender, 
                  items:n, 
                  onChanged: (value){
                    gender =value; 
                    error1=false; 
                    setState((){
                    });
                  },
                  underline: SizedBox(), 
                  hint: Text(
                    'Please select an option'
                  ),
                ),),),],
              ), ),),
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
                          child: Text("Please select a gender above",
                          style: TextStyle(color: Colors.red)
                          ),
                      ),
                    ],
                  )                        
                ),
              ),
          
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                  padding: EdgeInsets.only( top: 20, left: 20),
                  child: Text( 'Date of Birth', style: TextStyle(color: Colors.grey[600], fontSize: 19) ),
                  ),
                  Container(
                  padding: EdgeInsets.only(top:15, left: 20),
                  child:RaisedButton(
                    child:Text(_dateTime == null ? 'DD-MM-YYYY': DateFormat('dd-MM-yyyy').format(_dateTime), style: TextStyle(color: Colors.grey[600], fontSize: 19) ),  
                    onPressed: (){
                      //print('here');
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget child){
                          return Theme(
                            data: ThemeData(
                              primarySwatch: Colors.pink,    
                              accentColor: Colors.deepOrange,
                              splashColor: Colors.deepOrange,
                            ),
                            child: child, 
                            );
                        }
                      ).then((date) {
                        setState(() {
                          error2=false;
                          _dateTime = date;
                        });
                      });
                      
                    },
                  ),)
                ],
              )
            ),

            
            SafeArea(
                child: !(error2 && validate)? Container() : Container(
                  // print(error1),
                  // print(validate),
                  
                  padding:EdgeInsets.only( top: 5), 
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        alignment: Alignment(-0.8,-0.9),
                          child: Text("Please select a date above",
                          style: TextStyle(color: Colors.red)
                          ),
                      ),
                    ],
                  )                        
                ),
              ),
          

            Container(
          
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(
                  icon: new Image.asset("asset/image/icon.png"),
                  onPressed: submit, 
                ),
              ),
            
            ),
          ],
          )  
        ),
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
  String email='', password='', confirmpassword='', _errorMessage; 
  bool validate=false; 
  bool error1=false, error2=false, error3=false; 
  final _formKey= GlobalKey<FormState>(); 

  void submit() async {
    setState(() => validate=true);
    _formKey.currentState.save();
    dynamic result = await _auth.registerWithEmailAndPassword(widget.firstName, widget.lastName, widget.gender, widget.date, email, password); 
    if (result == null){
      setState(() => _errorMessage = 'This email has already been registered');
    }else{
      print(result);
    }
    print(email); 
    print(password); 
    print(confirmpassword); 
    if (EmailValidator.validate(email, true) && (password.length<6) && (confirmpassword==password))
    {
      
        Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign3Screen()),); 
    }
    
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

              AppBar(
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0, left: 10),
                      child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
            Container(
              padding:EdgeInsets.only( top: 1, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> !EmailValidator.validate(input, true)? 'Please enter a valid email address' :null,
                    onSaved: (input)=> setState(() {
                      error1=true;
                      email=input.trim(); 
                    }),
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
                    onSaved: (input)=> setState(() {
                      error2=true;
                      password=input.trim(); 
                    }),
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
                    onSaved: (input)=> setState(() {
                      error3=true;
                      confirmpassword=input.trim(); 
                    }),
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

            SafeArea(
              child: _errorMessage != 'This email has already been registered'? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text(_errorMessage,
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top:50),
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
                    child: Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 22 )),
                  ),

                ),
              ),
            
            ),

            

            Container(
            
              padding: EdgeInsets.only(top: 20), 
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

                      
            
          ],
          )  
        ),
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
                      child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container (
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
          

            Container (
              child: Row(children: <Widget>[
              Container(
              
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
            
            
            Container(
              
                child: Container(
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Confirmation Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                    
                    ]
                    )),

                ),
              ),
            ]),),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
            child: Container(
            
                child: Center(
                  
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "An account confirmation request has been sent to your email. ",style: TextStyle(color: Colors.black, fontSize: 17)),
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
            padding: EdgeInsets.only(top: 50), 
              
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
                    child: Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 22 ))
                  ),

                ),
              ),
          ],
          )

        ),
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
  String _errorMessage=''; 
  
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  void submit() async {
    setState(() => _errorMessage = '');
    _formKey.currentState.save();
    var error = await _auth.resetPassword(email);     
    if (error != null){
      setState(() => _errorMessage = "User record not found");
     
      print(error);
    }else{
      Navigator.push(context,MaterialPageRoute(builder: (context)=> Forgot2Screen()),); 
    }
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

              AppBar(
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60.0, left: 10),
                      child: Text('Forgot Password',style: TextStyle(color: Colors.white, fontSize: 25 ))
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
        child: SingleChildScrollView(
          child: Column(children: <Widget>[          
            Container(
              padding: EdgeInsets.only(top: 25), 
                child: Container(
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "We'll send instructions on how to reset your password to the email address you have registered with us ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    
                    ]
                    )),

                ),
              
            ),

            
            Container(
              padding:EdgeInsets.only( top: 30, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input.isEmpty? 'Please enter an email': null,
                    onSaved: (input)=> email=input.trim(),
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
            SafeArea(
              child: _errorMessage != "User record not found"? Container() : Container(
                
                padding:EdgeInsets.only( top: 5), 
                child: Column(
                  children: <Widget>[
                    
                    Container(
                      alignment: Alignment(-0.8,-0.9),
                        child: Text(_errorMessage,
                        style: TextStyle(color: Colors.red)
                        ),
                    ),
                  ],
                )                        
              ),
            ),

          Container(
            padding: EdgeInsets.only(top: 50, left: 0), 
                
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
                    child: Center(
                    child: Text("Send",style: TextStyle(color: Colors.white, fontSize: 22 ))),
                  ),

                ),
              
                
            ),
            
            Container(
            padding: EdgeInsets.only(top: 20, left: 0), 
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
            

          ],
          )  
        ),
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
                      child: Text('Forgot Password',style: TextStyle(color: Colors.white, fontSize: 28 ))
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
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container (
              child: Row(children: <Widget>[
              Container(
              
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
            
            
            Container(
              
                child: Container(
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Recovery Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                    
                    ]
                    )),

                ),
              ),
            ]),),

            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20), 
            
                child: Center(
                  
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "An email has been successfully sent to you with password reset instructions.",style: TextStyle(color: Colors.black, fontSize: 17)),
                      TextSpan(text: "Questions?",style: TextStyle(color: Colors.black, fontSize: 17)),
                      TextSpan(text: " Contact us on ",style: TextStyle(color: Colors.black, fontSize: 17)),
                      TextSpan(text: "help.rateit@gmail.com ",style: TextStyle(color: Colors.pink[800], fontSize: 17))
                    ]
                    )),

                ),
              
            ),

            
          Container(
            padding: EdgeInsets.only(top: 50), 
              
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

          ],
          )  
        ),
      )
    ); 
  }
}