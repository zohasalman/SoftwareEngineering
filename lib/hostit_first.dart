import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Event.dart';
import 'hostit.dart';
import 'userRedirection.dart';
import 'userRedirection.dart';
import 'hostit.dart';
import 'login.dart';
import 'user.dart';
import 'firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';


// void main() => runApp(new MyApp());//one-line function

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //build function returns a "Widget"
//     final materialApp = new MaterialApp(
//       title: '',
//       // ignore: strong_mode_invalid_cast_new_expr
//       home: new ListViewExample(),
//     );
//     return materialApp;
//   }
// }

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

// class ListViewExample extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return new ListViewExampleState();
//   }
// }
// class ListViewExampleState extends State<ListViewExample> {
  
//   var eventdata = [
//     new Event(
//       coverimage:"https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FCover%2Fkarachi-eat-2017.jpg?alt=media&token=da800a5d-2413-4f1b-bce5-0b04299215b7",
//       eventID:"cVgoRCSqbBCrjM6fg2Np",
//       logo:"https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FLogo%2Fimages.png?alt=media&token=bdfc149d-27e2-46a9-a40e-5434ef3209c2",
//       invitecode:"khieat",
//       location1:null,// GeoPoint(longitude: 60.9, latidude: 20.4),
//       name:"Karachi Eat",
//       uid:"aDsAvwk0mbgV1CQSUI5wJbU75Zt2"
//     ),
//     new Event(
//       coverimage:"https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FCover%2Fcokefestcover.jpg?alt=media&token=7bbf5d5d-e5b8-4a31-a397-2d817e4dc347",
//       eventID:"cVgoRCSqbBCrjM6fg2Np",
//       logo:"https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/EventData%2FLogo%2Fcokefest.png?alt=media&token=79d901a3-6308-40fa-8b4d-08c809e37691",
//       invitecode:"khieat",
//       location1:null,//new GeoPoint(longitude: 60.9, latidude: 20.4),
//       name:"Coke Fest",
//       uid:"aDsAvwk0mbgV1CQSUI5wJbU75Zt2"
//     )
//   ];
   
//   List<GestureDetector> _buildListItemsFromEvents(){
//     int index = 0;
//     return eventdata.map((eventdata){
//       var container = Card(//child:GestureDetector(

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[

//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: ClipRRect(
//                     child: Container(child: Image.network('$eventdata.logo')),
//                     borderRadius: BorderRadius.circular(16)
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left:10.0),
//                   child: Text(
//                     eventdata.name,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     child: Image(
//                       image: NetworkImage(
//                         eventdata.coverimage,
//                       ),
//                       height: 200,
//                       width: 350,
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),//),
//       );
//       index = index + 1;
//       final gestureDetector = GestureDetector(
//         child: container,
//         onTap: (){
//           //write code here
//           //var eventToBeEntered=eventdata.name;
//           Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu()),);
//         },
//       );
//       return gestureDetector;
//     }).toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//       return ListView(
//         children: _buildListItemsFromEvents(),
//       );
//   }
// }

class HostitHomescreen extends StatefulWidget {
  @override
  _HostitHomescreenState createState() => _HostitHomescreenState();
}

class _HostitHomescreenState extends State<HostitHomescreen> {
  final GlobalKey <FormState> _formKey= GlobalKey<FormState>(); 
  var scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
      value: FirestoreService().getEventsInfo(Provider.of<User>(context, listen: false).uid.toString()),
      child: Scaffold( 
      endDrawer: SideBar1(),
      key: scaffoldKey,
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
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState.openEndDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                      ),
                    )
                  ),
                ],
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
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Text(
              "Long Press to delete event",
              style: TextStyle(color: Colors.pink[600], fontSize: 17),
            ),
          ), 
          EventsListHostit(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //add code
          Navigator.push(context,MaterialPageRoute(builder: (context)=> AddEvent(coord: null,)),);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red[600],
      ),
    ),);
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

class EventsListHostit extends StatefulWidget {

  @override
  _EventsListStateHostIt createState() => _EventsListStateHostIt();
}

class _EventsListStateHostIt extends State<EventsListHostit> {

  @override
  Widget build(BuildContext context) {

    final events = Provider.of<List<Event>>(context);
    if (events == null){
      return LoadingScreen();
    }else{
      return Expanded(
          child: 
          ListView.builder(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EventMenu(eid:events[index].eventID,eventName:events[index].name,inviteCode:events[index].invitecode ,)),);
                  },
                  onLongPress: ()async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Confirm"),
                          content: Text("Are you sure you want to delete this vendor?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                await Firestore.instance.collection('Event').document(events[index].eventID).delete();
                                Navigator.of(context).pop(false);
                              },
                              child: Text("Delete"),
                            ),
                            FlatButton(
                              onPressed: ()=>Navigator.of(context).pop(false),
                              child: Text("Cancel"),
                            )
                          ],
                        ); 
                      },
                    ); 
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: ClipOval(
                                    child: Image.network(
                                      '${events[index].logo}',
                                    ),
                                ),
                              ),
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape:BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:10.0),
                            child: Text(
                              events[index].name,
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
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  events[index].coverimage,
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
                ),
              );
            }
          ),
        );
    }
  }
}