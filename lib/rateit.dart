import 'package:flutter/material.dart';
import 'dart:math' as math;

void main3() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner:  false,
    home: EditScreen()
  )
);


class EditScreen extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return _EditScreen();
  }
}

class _EditScreen extends State<EditScreen> {

  final double  _minimumPadding = 2;

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      body: Container(
        margin: EdgeInsets.all(3),
        child: ListView(
          children: <Widget>[
            Container (
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
                    height: 285,
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
                                padding: EdgeInsets.only(bottom: 50, top: 87, left: 80, right: 80),
                                child:Text("Edit Profile",style: TextStyle(color: Colors.white, fontSize: 22 )))), 
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
            offset: Offset(-180,-280),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/leftarrow.png")
                    ),
                ), 
              ),
            ),
            ),
          ),
          Container (
            child: Transform.translate(
            offset: Offset(0.0,-200),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/circular.png")
                    ),
                ), 
              ),
            ),
            ),
          ),
          
        ],
        ),
    ),

    

    Padding(
    padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
     child: Container(
     child: Transform.translate(
       offset: Offset (0.0, -120.0),
     child: Text("Account Info",style: TextStyle(color: Colors.black, fontSize: 22 )),
    ),
     ),
    ),

    Padding (
      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(-50,-100),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/name.png"),
                    ),
                ),
          ), 
            )
              ),
          ),
          ),

        //  Container(
        //     padding:EdgeInsets.only( top: 35, left: 20, right: 20),
        //     child: Column(
        //       children: <Widget>[
        //         TextField(
        //           decoration: InputDecoration(
        //             labelText: 'Name',
        //             hintText: 'Enter your name'
        //             )
        //           ),
        //       ],
        //     )
        //   ),
          Expanded(child: Transform.translate(offset: Offset(-80,-100),
          child: Column(
            children: <Widget>[
              TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name?',
                hintText: "Enter New Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )

            ],
          ) 
          )),
        

          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(50,-100),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/rightarrow.png"),
                    ),
                ),
              ),
            ), 
          ),
        ),
      ),



        ],
      )
    ),

    Padding (
      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(-50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/email.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),

          Expanded(child: Transform.translate(offset: Offset(-80,-100),
            child: Text("Email",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          )),

          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(50,-100),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/rightarrow.png"),
                    ),
                ),
          ),
            ), 
              ),
          ),
          ),



        ],
      )
    ),

    Padding (
      padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(-50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/password.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),

          Expanded(child: Transform.translate(offset: Offset(-80,-100),
            child: Text("Password",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          )),

          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/rightarrow.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),



        ],
      )
    ),

    Padding (
      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(-50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/gender.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),

          Expanded(child: Transform.translate(offset: Offset(-80,-100),
            child: Text("Gender",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          )),

        
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(50,-100),
            child: GestureDetector(
              onTap: () {
                debugPrint('Pressed');
              },
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/rightarrow.png"),
                    ),
                ),
            ),
          ), 
              ),
          ),
          ),



        ],
      )
    ),

    Padding (
      padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(-50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/calender.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),

          Expanded(child: Transform.translate(offset: Offset(-80,-100),
            child: Text("Date Of Birth",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          )),

          Expanded(child: Container(
            child: Transform.translate(
            offset: Offset(50,-100),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/rightarrow.png"),
                    ),
                ),
          ), 
              ),
          ),
          ),



        ],
      )
    )
    

           

          ],
        )

      ),
    );
  }}