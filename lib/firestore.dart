import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rateit/user.dart';
import 'Event.dart';
import 'localData.dart';
import 'vendor.dart';
import 'user.dart';
import 'item.dart';
import 'my-rating.dart';


class FirestoreService{

  final String uid;
  FirestoreService({this.uid});

  final CollectionReference _usersCollectionReference = Firestore.instance.collection('users');
  final CollectionReference _vendorCollectionReference = Firestore.instance.collection('Vendor');
  final CollectionReference _itemCollectionReference = Firestore.instance.collection('item');
  final CollectionReference _reviewsCollectionReference = Firestore.instance.collection('review');
  final CollectionReference _ratingCollectionReference = Firestore.instance.collection('rating');
  final CollectionReference _eventCollectionReference = Firestore.instance.collection('Event');

  Future registerUser(UserData user) async{
    try {
      await _usersCollectionReference.document(user.uid).setData(user.toJSON());
    } catch (e) {
      return e.message;
    }
  }

  Future<String> getUserData(String uid) async {
    try{
      String userRole = '';
      await _usersCollectionReference.document(uid).get().then((value) => userRole = value.data['userRole']);
      return userRole;
    }catch(e){
      return e.toString();
    }
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid : snapshot.data['uid'],  
      firstName : snapshot.data['firstName'], 
      lastName : snapshot.data['lastName'], 
      gender : snapshot.data['gender'], 
      dateOfBirth : snapshot.data['dateOfBirth'], 
      email : snapshot.data['email'], 
      userRole : snapshot.data['userRole'],
    );
  }

  Stream<UserData> get userData {
    return _usersCollectionReference.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  Future<String> userRolePromise(String uid) async {
    try{
      String userrole = '';
      await Firestore.instance.collection("users").document(uid).get().then((value){
        userrole = value.data['userRole'];
        writeContent(value.data);
      });
      //print('called');
      return userrole;
    }catch(e){
      return "Error";
    }
  }

  Future updateEventID(String eid) async {
    return await Firestore.instance.collection('Event').document(eid).setData({'eventID':eid});
  }

 Future<String> addEventPromise(Event data) async {
    try{
      String id='';
      await Firestore.instance.collection("Event").add(data.toJSON()).then((eid){
        id=eid.toString();
        updateEventID(id);
      });
      print('calledYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYy');
      return id;
    }catch(e){
      return "Error";
    }
  }

  Stream<String> get users  {
    return userRolePromise(uid).asStream();
  }

  Future normalSignOutPromise()  async{
    try{
      return await FirebaseAuth.instance.signOut();
    }
    catch(e){
      return null;
    }
    //return LoginScreen();
    // BuildContext context;
    // Navigator.push(context,MaterialPageRoute(builder: (context)=>  LoginScreen() ),);
  }

  // rate it backend 
  List<Vendor> _vendorListFromSnapshot(QuerySnapshot snapshot){
    return  snapshot.documents.map((doc){
      return Vendor(
        aggregateRating: doc.data['aggregateRating'] ?? 0,
        email: doc.data['email'] ?? '',
        eventId: doc.data['eventId'] ?? '',
        name: doc.data['name'] ?? '',
        qrCode: doc.data['qrCode'] ?? '',
        stallNo: doc.data['stallNo'] ?? -1,
        vendorId: doc.data['vendorId'] ?? '',
        logo: doc.data['logo'] ?? '',
      );
    }).toList();
  }

  Future<QuerySnapshot> verifyInviteCode(String inviteCode) async {
    return await Firestore.instance.collection('Event').where('invitecode', isEqualTo: inviteCode).getDocuments();
  }

  Stream<List<Vendor>> getVendorInfo(String eventID) {
    return _vendorCollectionReference.where('eventId', isEqualTo: eventID).orderBy('aggregateRating', descending: true).snapshots()
    .map(_vendorListFromSnapshot);
  }

  // for Vendor Details
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    print(snapshot.documents.toString());
    return snapshot.documents.map((doc){
      return Item(
        itemId: doc.data['itemId'] ?? '',
        name: doc.data['name'] ?? '',
        vendorId: doc.data['vendorId'] ?? '',
        logo: doc.data['logo'] ?? '',
        aggregateRating: doc.data['aggregateRating'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Item>> getItemInfo(String vendorId){ //each vendor's top rated item query
    print('vendorId');
    return _itemCollectionReference.where('vendorId', isEqualTo: vendorId).snapshots()
    .map(_itemListFromSnapshot);
  }
    
  Future<QuerySnapshot> getReviewsInfo(String vendorId){ // gets each vendor's reviews
    return _reviewsCollectionReference.where('vendorId', isEqualTo: vendorId).getDocuments();
  }

  // For Rating
  Future<QuerySnapshot> getVendor(String vendorId){
    return _vendorCollectionReference.where('vendorId', isEqualTo: vendorId).getDocuments();
  }

  Stream<List<Item>> getAllItemInfo(String vendorId){ //each vendor's all item query
    return _itemCollectionReference.where('vendorId', isEqualTo: vendorId).snapshots()
    .map(_itemListFromSnapshot);
  }

  //view my rating
   List<MyRating> _ratingListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return MyRating(
        itemId: doc.data['itemId'] ?? '',
        userId: doc.data['userId'] ?? '',
        ratingId: doc.data['ratingId'] ?? '',
        vendorId: doc.data['vendorId'] ?? '',
        vendorName: doc.data['vendorName'] ?? '',
        vendorLogo: doc.data['vendorLogo'] ?? '',
        rating: doc.data['rating'] ?? 0,
        // timeStamp: doc.data['timeStamp'] ?? '',
      );
    }).toList();
  }

  Stream<List<MyRating>> getMyRating(String uid){
    print("helloooo");
    print(uid);
    print("hogyaaa");
    return _ratingCollectionReference.where('userId', isEqualTo: uid).snapshots()
    .map(_ratingListFromSnapshot);
  }

  Stream<List<Item>> getMyRatingItem(String itemId){
    return _itemCollectionReference.where('itemId', isEqualTo: itemId).snapshots()
    .map(_itemListFromSnapshot);
  }



  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot){
    return  snapshot.documents.map((doc){
      return Event(
        coverimage: doc.data['coverimage'],
        eventID: doc.data['eventID'],
       //enddate: doc.data['enddate'],
        name: doc.data['name'],
        //startdate: doc.data['startdate'],
        invitecode: doc.data['invitecode'],
        location1: doc.data['location1'],
        logo: doc.data['logo'],
        uid:doc.data['uid'],
      );
    }).toList();
  }

  Stream<List<Event>> getEventInfo(String eventID) {
    return _eventCollectionReference.snapshots()
    .map(_eventListFromSnapshot);
  }

}