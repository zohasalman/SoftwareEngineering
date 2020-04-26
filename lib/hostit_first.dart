import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'data.dart';

void main() => runApp(new MyApp());//one-line function

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //build function returns a "Widget"
    final materialApp = new MaterialApp(
      title: '',
      // ignore: strong_mode_invalid_cast_new_expr
      home: new ListViewExample(),
    );
    return materialApp;
  }
}

class ClipShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var clipline= new Path();
    clipline.lineTo(0, size.height-0);
    clipline.lineTo(size.width, size.height-100);
    clipline.lineTo(size.width, 0);
    return clipline;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ListViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewExampleState();
  }
}
class ListViewExampleState extends State<ListViewExample> {
  List<Card> _buildListItemsFromFlowers(){
    int index = 0;
    return flowers.map((flower){
      var container = Card(
        child: new Row(
          children: <Widget>[



            new Container(
              margin: new EdgeInsets.all(10.0),
              child:CircleAvatar(
                backgroundImage: AssetImage(
                  "asset/image/noliesfries.png",
                ),
              ),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new Text(
                    flower.flowerName,
                    style: new TextStyle(
                        fontWeight:  FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black
                    ),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment(-0.75,-0.75),
                    child: new Image.asset(
                      'asset/image/123.jpg',
                      height: 250.0,
                      width: 300.0,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
      index = index + 1;
      return container;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
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
                            child: Text('My Events',style: TextStyle(color: Colors.white, fontSize: 28 ))
                        ),
                      )
                  ),
                  leading: IconButton(
                      icon: Icon(
                        Icons.menu,

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
      body: ListView(
        children: _buildListItemsFromFlowers(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //add code
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}