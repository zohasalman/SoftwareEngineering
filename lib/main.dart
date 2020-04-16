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
      body: Container (
        decoration: BoxDecoration(
          ),
        child: Transform.scale(
          scale: 1.5,  
          child: Transform.rotate(
            angle: -math.pi/18,
            child: Transform.translate(
              offset: Offset(0,-60),
              child: Container (
                height: 200,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
