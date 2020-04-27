import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Event.dart';
import 'hostit.dart';
import 'userRedirection.dart';
import 'userRedirection.dart';
import 'hostit.dart';
import 'login.dart';
import 'user.dart';
import 'firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';


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

// class ClipShape extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     var clipline= new Path();
//     clipline.lineTo(0, size.height-0);
//     clipline.lineTo(size.width, size.height-100);
//     clipline.lineTo(size.width, 0);
//     return clipline;
//   }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

class ListViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewExampleState();
  }
}
class ListViewExampleState extends State<ListViewExample> {
  
   
  List<GestureDetector> _buildListItemsFromEvents(eventdata){
    int index = 0;
    return eventdata.map((flower){
      var container = Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('$eventdata.logo')
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10.0),
                  child: Text(
                    eventdata.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image(
                      image: NetworkImage(
                        eventdata.coverimage,
                      ),
                      height: 200,
                      width: 350,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
      index = index + 1;
      final gestureDetector = GestureDetector(
        child: container,
        onTap: (){
          //write code here
          var eventToBeEntered=eventdata.name;
        },
      );
      return gestureDetector;
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
      endDrawer: SideBar1(),
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
                  // leading: IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back,

                  //     ),
                  //     onPressed: (){
                  //       Navigator.pop(context);
                  //       //add code
                  //     }),
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



class SideBar1 extends StatefulWidget {
  @override
  SideBar1Properties createState() => new SideBar1Properties();
}

class SideBar1Properties extends State<SideBar1>{

  void NormalSignOut() async {
    User usr = Provider.of<User>(context, listen: false);
    String user = usr.uid;
    await FirestoreService(uid: user).normalSignOutPromise();
    LoginScreen();
  
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
        
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Padding( padding: EdgeInsets.all(30),),
            CircleAvatar(
              radius:70, 
              backgroundImage: AssetImage("asset/image/user.png"),
            ),
            Text(
              'Aladin', 
              style: TextStyle(fontSize: 30, color: Colors.black)
            ),
            Text(
              'Aladin@hotmail.com', 
              style: TextStyle(fontSize: 22, color: Colors.black)
            ),
          Padding( padding: EdgeInsets.all(30),),
          Container(
            child: GestureDetector(
              onTap: () { //Change on Integration
                Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()),);
              },
              child: Container(
                width: 230.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [ 
                      Color(0xFFAC0D57),
                      Color(0xFFFC4A1F),
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Edit Profile',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
          Padding( padding: EdgeInsets.all(20),),
          Container(
            child: GestureDetector(
              onTap:() async {await FirestoreService().normalSignOutPromise();},
             // },
              child: Container(
                width: 230.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [ 
                      Color(0xFFAC0D57),
                      Color(0xFFFC4A1F),
                    ]
                  ),
                  boxShadow: const[BoxShadow(blurRadius: 10),],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:Center(
                  child: 
                    Text('Sign Out',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22
                      ) 
                    ),
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}