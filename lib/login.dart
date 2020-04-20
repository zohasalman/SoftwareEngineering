import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rateit/login_backend.dart';
import 'package:rateit/rateit.dart';
import 'VendorList.dart';

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
  @override 
  FirstScreen createState()=> new FirstScreen(); 
}

final FirebaseAuth auth = FirebaseAuth.instance;

class FirstScreen extends State<LoginScreen> {
  String _email, _password; 
  bool rememberme=false;
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 

  void submit(){
    _formKey.currentState.save();
    dynamic userId = "";
    try{
      userId = signIn(_email, _password);
      print("User Signed In: $userId");
      Navigator.push(context,MaterialPageRoute(builder: (context)=> EditScreen()),); 
    }catch(e){
      print("Error: $e");
      _formKey.currentState.reset();
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
  @override 
  SecondScreen createState()=> new SecondScreen(); 
}


class SecondScreen extends State<SignScreen> {
  String firstname, lastname, gender, month, day,year ; 
  
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  List<DropdownMenuItem<String>> m=[];
  List<DropdownMenuItem<String>> d=[];
  List<DropdownMenuItem<String>> y=[];
  

  void loadData(){
    m=[];
    m.add(new DropdownMenuItem(
      child: new Text('1'),
      value: '1')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('2'),
      value: '2')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('3'),
      value: '3')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('4'),
      value: '4')
    ); 

    m.add(new DropdownMenuItem(
      child: new Text('5'),
      value: '5')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('6'),
      value: '6')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('7'),
      value: '7')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('8'),
      value: '8')
    ); 

    m.add(new DropdownMenuItem(
      child: new Text('9'),
      value: '9')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('10'),
      value: '10')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('11'),
      value: '11')
    ); 
    m.add(new DropdownMenuItem(
      child: new Text('12'),
      value: '12')
    ); 

    d=[];
    d.add(new DropdownMenuItem(
      child: new Text('1'),
      value: '1')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('2'),
      value: '2')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('3'),
      value: '3')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('4'),
      value: '4')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('5'),
      value: '5')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('6'),
      value: '6')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('7'),
      value: '7')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('8'),
      value: '8')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('9'),
      value: '9')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('10'),
      value: '10')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('11'),
      value: '11')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('12'),
      value: '12')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('13'),
      value: '13')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('14'),
      value: '14')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('15'),
      value: '15')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('16'),
      value: '16')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('17'),
      value: '17')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('18'),
      value: '18')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('19'),
      value: '19')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('20'),
      value: '20')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('21'),
      value: '21')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('22'),
      value: '22')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('23'),
      value: '23')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('24'),
      value: '24')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('25'),
      value: '25')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('26'),
      value: '26')
    ); 

    d.add(new DropdownMenuItem(
      child: new Text('27'),
      value: '27')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('28'),
      value: '28')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('29'),
      value: '29')
    ); 
    d.add(new DropdownMenuItem(
      child: new Text('30'),
      value: '30')
    ); 

    y=[]; 
    y.add(new DropdownMenuItem(
      child: new Text('1950'),
      value: '1950')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1951'),
      value: '1951')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1952'),
      value: '1952')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1953'),
      value: '1953')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1954'),
      value: '1954')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1955'),
      value: '1955')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1956'),
      value: '1956')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1957'),
      value: '1957')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1958'),
      value: '1958')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1959'),
      value: '1959')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1960'),
      value: '1960')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1961'),
      value: '1961')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1962'),
      value: '1962')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1963'),
      value: '1963')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1964'),
      value: '1964')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1965'),
      value: '1965')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1966'),
      value: '1966')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1967'),
      value: '1967')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1968'),
      value: '1968')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1969'),
      value: '1969')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1970'),
      value: '1970')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1971'),
      value: '1971')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1972'),
      value: '1972')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1973'),
      value: '1973')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1974'),
      value: '1974')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1975'),
      value: '1975')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1976'),
      value: '1976')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1977'),
      value: '1977')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1978'),
      value: '1978')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1979'),
      value: '1979')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1980'),
      value: '1980')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1981'),
      value: '1981')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1982'),
      value: '1982')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1983'),
      value: '1983')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1984'),
      value: '1984')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1985'),
      value: '1985')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1986'),
      value: '1986')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1987'),
      value: '1987')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1988'),
      value: '1988')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1989'),
      value: '1989')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1990'),
      value: '1990')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1991'),
      value: '1991')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1992'),
      value: '1992')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1993'),
      value: '1993')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1994'),
      value: '1994')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1995'),
      value: '1995')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1996'),
      value: '1996')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1997'),
      value: '1997')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1998'),
      value: '1998')
    );
    y.add(new DropdownMenuItem(
      child: new Text('1999'),
      value: '1999')
    );
    y.add(new DropdownMenuItem(
      child: new Text('2000'),
      value: '2000')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2001'),
    value: '2001')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2002'),
    value: '2002')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2003'),
    value: '2003')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2004'),
    value: '2004')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2005'),
    value: '2005')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2006'),
    value: '2006')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2007'),
    value: '2007')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2008'),
    value: '2008')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2009'),
    value: '2009')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2010'),
    value: '2010')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2011'),
    value: '2011')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2012'),
    value: '2012')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2013'),
    value: '2013')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2014'),
    value: '2014')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2015'),
    value: '2015')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2016'),
    value: '2016')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2017'),
    value: '2017')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2018'),
    value: '2018')
    );
    y.add(new DropdownMenuItem(
    child: new Text('2019'),
    value: '2019')
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
                  onSaved: (input)=> firstname=input,
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
                  onSaved: (input)=> firstname=input,
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
                  onSaved: (input)=> firstname=input,
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
                value:month, 
                
                items:m, 
                onChanged: (value){
                  month=value; 
                  setState((){
                  });
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
                value:day, 
                
                items:d, 
                onChanged: (value){
                  day=value; 
                  setState((){
                  });
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
                value:year, 
                
                items:y, 
                onChanged: (value){
                  year=value; 
                  setState((){
                  });
                },
                
                hint: Text(
                  "Year"
                ),
              ),
            ), 
          ), 

          Expanded (
            child: Transform.translate(
            offset: Offset(0,-50),
              child: Container(
                height: 100,
                width: 200,
                child: new IconButton(icon: new Image.asset("asset/image/icon.png"),onPressed:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign2Screen()),) ),
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
  @override 
  ThirdScreen createState()=> new ThirdScreen(); 
}


class ThirdScreen extends State<Sign2Screen> {
  String email, password, confirmpassword ; 
  
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
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Sign3Screen()),);  
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
