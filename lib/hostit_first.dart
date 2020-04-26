import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Event.dart';
import 'userRedirection.dart';
import 'userRedirection.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
  
   
  List<Card> _buildListItemsFromEvents(eventdata){
    int index = 0;
    return eventdata.map((flower){
      var container = Card(
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(10.0),
              child:CircleAvatar(
                backgroundImage: NetworkImage('$eventdata.logo'),
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
                  child: CachedNetworkImage(
                    imageUrl: eventdata.coverimage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
    final eventdata = Provider.of<List<Event>>(context);
    if (eventdata==null){
      return LoadingScreen();
    }else{
      return ListView(
        children: _buildListItemsFromEvents(eventdata),
      );
    }
  }
}

class HostitHomescreen extends StatefulWidget {
  @override
  _HostitHomescreenState createState() => _HostitHomescreenState();
}

class _HostitHomescreenState extends State<HostitHomescreen> {
  @override
  Widget build(BuildContext context) {
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
      body: ListViewExample(),
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