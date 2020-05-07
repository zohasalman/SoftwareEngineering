import 'package:flutter/material.dart';
import 'package:rateit/auth.dart';
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
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/LoginScreen' : (BuildContext context) => new LoginScreen(),
        '/SignScreen' : (BuildContext context) => new SignScreen(),
        '/Sign2Screen' : (BuildContext context) => new Sign2Screen(),
        '/Sign3Screen' : (BuildContext context) => new Sign3Screen(),
        '/ForgotScreen' : (BuildContext context) => new ForgotScreen(),
        '/Forgot2Screen' : (BuildContext context) => new Forgot2Screen(),
      },
    theme: new ThemeData(
      primaryColor: Color(0xFFAC0D57),
      splashColor: Color(0xFFFC4A1F),
 

    ),
    debugShowCheckedModeBanner:  false,
    home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {              //First sign in screen which comes after the welcome screen
  final Function toggleView;
  LoginScreen({this.toggleView});
  @override 
  LoginScreenState createState()=> new LoginScreenState(); 
}

final AuthService _auth = AuthService();

class LoginScreenState extends State<LoginScreen> {

  String _email = '';
  String _password = '';
  String _errorMessage = ''; 
  bool rememberme=false;
  bool hasInfo = false;

  final emailCont = TextEditingController();
  final pwCont = TextEditingController();

  final _formKey= GlobalKey<FormState>();                       //Validation error checks 

  
  void submit() async {                                                         //Submit function for the end submission button
    //await Directory( (await getTemporaryDirectory()).path ).delete(recursive: true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _errorMessage = '');                                     //Clearing error message each time submit is clicked to refresh the page 
    _formKey.currentState.save();
    prefs.setBool('rememberMe', rememberme);                                          //When the user clicks remember me 
    if (rememberme == true){
      prefs.setString('email', _email);
      prefs.setString('password', _password);
    }

    dynamic result = await _auth.signInEmailAndPassword(_email, _password);

    if (result == null){                                                          
      setState(() => _errorMessage = 'Invalid email or password combination.');                          //If the email and password do not match in firebase then display error on submit 
    }else{
      Redirection();
    }
  }

  void autoLogIn() async {                                                            //Function for remember me as then username and password would be remembered by the user 
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

              AppBar(                                                                             //App design top bar
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
                  gradient: LinearGradient(                                           //Setting colour gradient of raspberry jam and orange 
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [ 
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]
                  ),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",                                 //Adding background image 
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
                  
                  SafeArea(                                                             //Asking the user for the email address on sign in screen 
                    child: Padding(
                    padding:EdgeInsets.only( top: 30, left: 20, right: 20), 
                    child:TextFormField(
                    controller: emailCont,
                    initialValue: hasInfo? _email: null,
                    validator: (input)=> input.isEmpty? null : null,
                    onChanged: (input)=> _email = input.trim(),
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

            SafeArea(                                                                         //Asking the user for their password 
            
              child: Column(
                children: <Widget>[
                  SafeArea(
                    
                    child: Padding(
                    padding:EdgeInsets.only( top: 0, left: 20, right: 20), 
                    child:TextFormField(
                    controller: pwCont,
                    initialValue: hasInfo? _password: null,
                    validator: (input)=> input.length<6? 'Please enter a password with at least 6 characters': null,
                    onChanged: (input)=> _password = input.trim(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 19
                      ),
                    ),
                    obscureText: true,
                  ),),),

                  SafeArea(                                                                                                       //If the firebase does not authenticate the user then an error message is displayed in red 
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

                  SizedBox(height: 7),                                                                //Forgot password icon: If the user forgets their password they are redirected to the forgot password screens once they click on the option
                  InkWell(
                    onTap: (){
                      // Navigator.of(context).pushNamed('/ForgotScreen'); 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen()));
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
                  
                  Container(                                                                  //Remember me icon: if the user clicks on this icon then the username and password is remembered for the user 
                    height:20,
                    child: Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.grey[600]),
                          child: Checkbox(
                            value: rememberme,
                            checkColor: Colors.grey[800],
                            activeColor: Color(0xFFFC4A1F),
                            onChanged: (value) {
                              setState(() {
                                rememberme = value;
                              });
                            }
                            )
                        ),
                        Text('Remember Me?',
                        style: TextStyle(color: Colors.grey[600])
                        ),
                      ],)

                  ),

                    SafeArea(                                                 //Submission button where the user signs up
                    child: Padding(
                      padding: EdgeInsets.only(top:40),
                      child: InkWell(
                        onTap: submit,                                  //If the user submits it checks from firebase and returns an error message or redirects 
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

                Container(                                                                  //If the user does not have an account then an option for signing up is also given: Once the user clicks on it redirected to sign up page
                  alignment: Alignment(0,0),
                  padding: EdgeInsets.only(top: 20, left: 0),
                  child: InkWell(
                    onTap: (){
                      _formKey.currentState.reset(); 
                      // Navigator.of(context).pushNamed('/SignScreeen'); 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignScreen()));
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
                      child: Text('Or',                                         //Another option of signing through fb or google is also provided 
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
                        image: AssetImage("asset/image/facebook.png")                         //If the user decides to use facebook to sign in he/she is redirected to the facebook page 
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
                        image: AssetImage("asset/image/google.png")                             //If the user decides to use google to sign in then he/she is redirected to the gmail page where they can enter their credentails 
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

class SignScreen extends StatefulWidget {                   //Screen that appears on clicking the sign up option: 3 screens in sign up continuation this is the first one 
  
  final Function toggleView;
  SignScreen({this.toggleView});

  @override 
  SignScreenState createState()=> new SignScreenState(); 
}


class SignScreenState extends State<SignScreen> {                  
  String firstName='', lastName='', gender; 
  bool error1=true, error2=true; 

  DateTime _dateTime; 

  bool validate=false;                //First false changed to true on the submit button 
  final _formKey= GlobalKey<FormState>();               //Validation forms

  void submit(){                                                      //Function is called when the user wants to go forward: It redirects user to next screen of sign up where email and password is asked 
    setState(() => validate=true);
    _formKey.currentState.save();
    if (!error1 && !error2 && (firstName!='') && (lastName!='')) {                            //First it is ensured that all fields are checked before the user is redirected 
      Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign2Screen(firstName: firstName, lastName: lastName, gender: gender,date: _dateTime)));
      // Navigator.pushNamed(context, '/Sign2Screen', arguments: {firstName: firstName, lastName: lastName, gender: gender, date: _dateTime});
    }
    
  }

  List<DropdownMenuItem<String>> n=[];                    //Drop down button initialisation for gender 
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

              AppBar(                           //Appbar for top design 
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0, left: 10),
                      child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 28 ))           //Screen title 
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
                      colors: [                         //Gradient 
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]
                  ),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",             //Background image 
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
        autovalidate: validate,                               //When clicked on submit form is validated to check for empty fields 
        child: SingleChildScrollView(
          child: Column(children: <Widget>[          
            Container(                                                    //First field where the user is asked to enter their first name 
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

            Container(                                                    //Second field where the user is asked to enter their last name 
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
            SafeArea(                                                   //Next the user has to select their gender from their dropdown 
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


            SafeArea(                                                       //If submit is clicked then have to make sure if the user clicks the dropdown: if the user hasnt selected an option from the dropdown then error message is displayed 
                child: !(error1 && validate)? Container() : Container(
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
            Container(                                            //To help the user choose the date of birth option from the calendar 
              child: Row(
                children: <Widget>[
                  Container(
                  padding: EdgeInsets.only( top: 20, left: 20),
                  child: Text( 'Date of Birth', style: TextStyle(color: Colors.grey[600], fontSize: 19) ),
                  ),
                  Container(
                  padding: EdgeInsets.only(top:15, left: 20),
                  child:RaisedButton(
                    child:Text(_dateTime == null ? 'DD-MM-YYYY': DateFormat('dd-MM-yyyy').format(_dateTime), style: TextStyle(color: Colors.grey[600], fontSize: 19) ),  //If date not displayed then display format else display the date 
                    onPressed: (){
                      //print('here');
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget child){
                          return Theme(                                         //Change the calender colour scheme 
                            data: ThemeData(
                              primarySwatch: Colors.pink,    
                              accentColor: Colors.deepOrange,
                              splashColor: Colors.deepOrange,
                            ),
                            child: child, 
                            );
                        }
                      ).then((date) {                           //Once date is selected: date is set up in a variable and a bool is declared for displaying error messages 
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

            
            SafeArea(                                                         //if date is not selected by the user and the form is validated then error message to display the error message 
                child: !(error2 && validate)? Container() : Container(
          
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
          

            Container(                                                              //The submission button (next) when clicked it ensures the values are saved and the user moves to the next screen 
          
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

class Sign2Screen extends StatefulWidget {                //Screen that appears on clicking the sign up option: 3 screens in sign up continuation this is the second one 

  Sign2Screen({this.firstName, this.lastName, this.gender, this.date});

  final String firstName, lastName, gender;
  final DateTime date;

  @override 
  Sign2ScreenState createState()=> new Sign2ScreenState(); 
}


class Sign2ScreenState extends State<Sign2Screen> {
  String email='', password='', confirmpassword='', _errorMessage; 
  bool validate=false; 
  bool error1=false, error2=false, error3=false; 
  final _formKey= GlobalKey<FormState>(); 

  void submit() async {
    setState(() => validate=true);
    _formKey.currentState.save();
    dynamic result = await _auth.registerWithEmailAndPassword(widget.firstName, widget.lastName, widget.gender, widget.date, email, password); //The user is registered and if the password and email are not authorised then the error message needs to be displayed 
    if (result == null){
      print(_errorMessage); 
      setState(() => _errorMessage = 'This email has already been registered');
    }else{
      print(result);
      // Navigator.of(context).pushNamed('/Sign3Screeen'); 
      Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign3Screen()),); 
    }
    // print(email); 
    // print(password); 
    // print(confirmpassword); 
   
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

              AppBar(                                                                 //App bar design for the top bar of the screen 
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
                      colors: [                                                 //The color gradient is set up for the top bar screen 
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]
                  ),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",                                     //Background screen is set up for login 
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
        autovalidate: validate,                           //set to true once the values are validated on clicking the submit button 
        child: SingleChildScrollView(
          child: Column(children: <Widget>[          
            Container(                                                    //First field that of entering email address of the user 
              padding:EdgeInsets.only( top: 1, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> !EmailValidator.validate(input, true)? 'Please enter a valid email address' :null,             //Flutter plugin checks if the email address is of a valid format 
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

            Container(                                                    //Password field 
              padding:EdgeInsets.only( top: 10, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input.length<6? 'Please enter a password with at least 6 characters': null,  //Checking if the password is more than 6 characters
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


            Container(                                                        //Confirming passwords text box
              padding:EdgeInsets.only( top: 10, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input!=password? 'Passwords do not match' : null,            //The password is checked from the password entered by the user above and checked if both the passwords match on clicking the submit button 
                    onSaved: (input)=> setState(() {
                      error3=true;                                                      //If not entered then the error message can be displayed 
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

            SafeArea(                                                                                           //Error message from the firebase if email has been registered only then error message is displayed in red 
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
            Container(                                                //Submission sign up so the user can move ahead on the third screen: On submission it checks if all fields are valid 
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

            

            Container(                                                                  //In case the user forgets that they might already have an account they can click on this sign in button and wouldbe redirected to the login screen 
            
              padding: EdgeInsets.only(top: 20), 
              child: InkWell(
                onTap: (){
                // Navigator.of(context).pushNamed('/LoginScreen'); 
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

class Sign3Screen extends StatefulWidget {                                    //Screen that appears on clicking the sign up option: 3 screens in sign up continuation this is the last one 
  @override 
  Sign3ScreenState createState()=> new Sign3ScreenState(); 
}


class Sign3ScreenState extends State<Sign3Screen> {
  
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

              AppBar(                                                       //App bar for the top design 
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
                leading: IconButton(                              //Back arrow 
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
                      colors: [                                             //gradient colour 
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]
                  ),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",                         //background image on the appbar 
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
              child: Container(                                               //Success tick mark on top of the screen 
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
              Container(                                              //Message diplayed below 
              
                child: Container(                                                   //Envelope image 
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
              
                child: Container(                                                       //Confirmation message of email sent to the user 
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
                    text: TextSpan(children: <TextSpan>[                                          //Information for the user: User friendly 
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

            
          Container(                                          //Sign in button at the bottom of the screen to redirect the user to login screen after account confirmation 
            padding: EdgeInsets.only(top: 50), 
              
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> new LoginScreen()),);        
                    
                  // Navigator.popUntil(context, ModalRoute.withName('/LoginScreen'));          
                },
                child: Container(

                    height: 50,
                    width: 250,
                    
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [                                     //gradient colour for submission 
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

class ForgotScreen extends StatefulWidget {                                                 //Forgot password screen: when the user forgets their password then the user can click on the forgot password button to redirect to the next screen 
  @override 
  ForgotScreenState createState()=> new ForgotScreenState(); 
}


class ForgotScreenState extends State<ForgotScreen> {                             //When the user checks for forget password: the original password stored in the database is sent to the user 
  String email; 
  String _errorMessage=''; 
  
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  void submit() async {
    setState(() => _errorMessage = '');
    _formKey.currentState.save();
    var error = await _auth.resetPassword(email);     
    if (error != null){                                                                         //If no account associated with email 
      setState(() => _errorMessage = "User record not found");
     
      print(error);
    }else{
      Navigator.push(context,MaterialPageRoute(builder: (context)=> Forgot2Screen()),);         //Directed to the success screen 
      // Navigator.of(context).pushNamed('/Forgot2Screen'); 
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

              AppBar(                                                                       //App bar for design at the top of the screen 
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
                    Icons.arrow_back,                                             //Back arrow 
                    ), 
                  onPressed: (){
                    Navigator.pop(context);
                    }),
                flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [                                                   //Two different colours for the gradient 
                        Color(0xFFAC0D57),
                        Color(0xFFFC4A1F),
                      ]
                  ),
                    image: DecorationImage(
                      image: AssetImage(
                        "asset/image/Chat.png",                                 //Image background on top of the screen 
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
                    text: TextSpan(children: <TextSpan>[                                    //User friendly info 
                      TextSpan(text: "We'll send instructions on how to reset your password to the email address you have registered with us ",style: TextStyle(color: Colors.black, fontSize: 17)),
                    
                    ]
                    )),

                ),
              
            ),

            
            Container(                                                        //Email field 
              padding:EdgeInsets.only( top: 30, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input)=> input.isEmpty? 'Please enter an email': null,              //check if valid email 
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
              child: _errorMessage != "User record not found"? Container() : Container(                   //IF user not found in the databse then returns an error message 
                
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

          Container(                                                        //Send option to send password to the user 
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
                // Navigator.of(context).pushNamed('/SignScreen');
              },
              child: new Container(
                //padding: EdgeInsets.only(top: 130, left: 20), 
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.grey[600])),                         //In case the user doesnt have an account and is trying to forget their password then an option is given to sign up
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

class Forgot2Screen extends StatefulWidget {                //Success screen when the password is sent to the user when he clicks on forget password 
  @override 
  Forgot2ScreenState createState()=> new Forgot2ScreenState(); 
}



class Forgot2ScreenState extends State<Forgot2Screen> {             
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

              AppBar(                                       //Appbar for top of the screen 
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
                        "asset/image/Chat.png",                                       //Background image of appbar 
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
              
                child: Container(                           //The image of the envelope at the top of the screen 
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
              
                child: Container(                                               //User friendly info text to show that email for password recovery is sent to the user 
                  padding: EdgeInsets.only(top: 0, left: 20), 
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Recovery Email Sent",style: TextStyle(color: Colors.black, fontSize: 22)),
                    
                    ]
                    )),

                ),
              ),
            ]),),

            Container(                                                              //User info -- describes additional contact info and the process that has happened at the backend 
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

            
          Container(                                                //Final submission button which redirects the user to the login screen so the user can see enter their credentials as sent by email to them 
            padding: EdgeInsets.only(top: 50), 
              
              child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);
                    // Navigator.of(context).pushNamed('/LoginScreen');
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