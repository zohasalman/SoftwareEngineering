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
  final CollectionReference _ratedVendorCollectionReference = Firestore.instance.collection('ratedVendor');
  final CollectionReference _ratedItemCollectionReference = Firestore.instance.collection('ratedItems');
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
        // writeContent(value.data);
      });
      //print('called');
      return userrole;
    }catch(e){
      return "Error";
    }
  }

//   Future updateEventID(String eid) async {
//     return await Firestore.instance.collection('Event').document(eid).setData({'eventID':eid});
//   }

//  Future<String> addEventPromise(Event data) async {
//     try{
//       String id='';
//       await Firestore.instance.collection("Event").add(data.toJSON()).then((eid){
//         id=eid.toString();
//         updateEventID(id);
//       });
//       return id;
//     }catch(e){
//       return "Error";
//     }
//   }

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

  // For Rating
  Future<QuerySnapshot> getVendor(String vendorId){
    print(vendorId);
    return _vendorCollectionReference.where('vendorId', isEqualTo: vendorId).getDocuments();
  }

  Stream<List<Item>> getAllItemInfo(String vendorId){ //each vendor's all item query
    return _itemCollectionReference.where('vendorId', isEqualTo: vendorId).snapshots()
    .map(_itemListFromSnapshot);
  }

  //view my rating
  List<RatedVendor> _ratedVendorListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return RatedVendor(
        userId: doc.data['userId'] ?? '',
        vendorId: doc.data['vendorId'] ?? '',
        vendorName: doc.data['vendorName'] ?? '',
        vendorLogo: doc.data['vendorLogo'] ?? '',
        rating: doc.data['myVendorRating'] ?? 0,
        reviewId: doc.data['reviewId'] ?? '',
      );
    }).toList();
  }

  Stream<List<RatedVendor>> getMyRatedVendor(String uid){
    print(uid);
    return _ratedVendorCollectionReference.where('userId', isEqualTo: uid).snapshots()
    .map(_ratedVendorListFromSnapshot);
  }

  List<RatedItem> _ratedItemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return RatedItem(
        userId: doc.data['userId'] ?? '',
        vendorId: doc.data['vendorId'] ?? '',
        itemName: doc.data['itemName'] ?? '',
        itemLogo: doc.data['itemLogo'] ?? '',
        rating: doc.data['myItemRating'] ?? 0,
        itemId: doc.data['itemId'] ?? '',
      );
    }).toList();
  }

  Stream<List<RatedItem>> getMyRatedItem(String uid, String vendorId){
    return _ratedItemCollectionReference.where('userId', isEqualTo: uid).where('vendorId', isEqualTo: vendorId).snapshots()
    .map(_ratedItemListFromSnapshot);
  }

  // do ratings
  
  // Future<QuerySnapshot> getReviewId(String userId, String vendorId){
  //   return _reviewsCollectionReference.where('userId', isEqualTo: userId).where('vendorId', isEqualTo: vendorId).getDocuments();
  // }

  Future<String> sendRatings(String uid, List<Map> itemRatings, String vendorName, String vendorLogo, String vendorId, String review, double vendorRating) async {
    // convert all the data to JSON
    int noOfItems = itemRatings.length;
    String reviewId = '';

    if (noOfItems > 0){
      if (review.isNotEmpty){
        // send review 
        Review rev = Review(userId: uid, vendorId: vendorId, review: review);
        try{
          final resp = await _reviewsCollectionReference.add(rev.toJSON());
          reviewId = resp.documentID;
        }catch(e){
          print(e.toString());
          
        }

        // add review Id:
        await _reviewsCollectionReference.document(reviewId).updateData({'reviewId': reviewId});

        // // get reviewId
        // await getReviewId(uid, vendorId).then((docs){
        //   if (docs.documents.isNotEmpty){
        //         reviewId = docs.documents[0].data['reviewId'];
        //       }
        // });
      }
      RatedVendor ven = RatedVendor(userId: uid, vendorId: vendorId, vendorName: vendorName, vendorLogo: vendorLogo, reviewId: reviewId, rating: vendorRating);
      try {
        final resp = await _ratedVendorCollectionReference.add(ven.toJSON());
        String ratedVendorId = resp.documentID;
        await _ratedVendorCollectionReference.document(ratedVendorId).updateData({'ratedVendorId': ratedVendorId});
      } catch (e) {
        print(e.toString());
      }
      itemRatings.forEach((item) async{
        RatedItem it = RatedItem(userId: uid, vendorId: vendorId, itemId: item['itemId'], itemName: item['name'], itemLogo: item['logo'], rating: item['givenRating']);
        try {
          final resp = await _ratedItemCollectionReference.add(it.toJSON());
          String ratedItemId = resp.documentID;
        await _ratedVendorCollectionReference.document(ratedItemId).updateData({'ratedItemId': ratedItemId});
        } catch (e) {
          print(e.toString());
        }
      });
      return null;
    }
    else{
      return 'No items were rated.';
    }
  }

  // edit rating 

  // getting document ids
  Future<List> getRatedVendorId(String userId, String vendorId) async {
    String docId = '';
    String reviewId = '';
    await _ratedVendorCollectionReference.where('userId', isEqualTo: userId).where('vendorId', isEqualTo: vendorId).getDocuments()
    .then((docs){
          if (docs.documents.isNotEmpty){
            docId = docs.documents[0].data['ratedVendorId'];
            reviewId = docs.documents[0].data['reviewId'];
          }
    });
    return [docId, reviewId];
  }

  Future<String> getRatedItemsDocumentId(String userId, String vendorId, String itemId) async {
    String docId = '';
    await _ratedVendorCollectionReference.where('userId', isEqualTo: userId).where('vendorId', isEqualTo: vendorId).where('itemId', isEqualTo: itemId)
    .getDocuments().then((docs){
          if (docs.documents.isNotEmpty){
            docId = docs.documents[0].data['ratedItemId'];
          }
    });
    return docId;
  }

  void updateRatings(String uid, List<Map> itemRatings, String vendorId, String review, double vendorRating) async {
    // convert all the data to JSON
    int noOfItems = itemRatings.length;
    String reviewId = '';
    String ratedVendorId = '';

    // getting vendorId;
    List<String> ids = await getRatedVendorId(uid, vendorId);
    ratedVendorId = ids[0];
    reviewId = ids[1];

    // update review
    if (review.isNotEmpty){
      // update review 
      try{
        await _reviewsCollectionReference.document(reviewId).updateData({'review': review});
      }catch(e){
        print(e.toString());
      }
    }

    // update rated vendor
    try {
      await _ratedVendorCollectionReference.document(ratedVendorId).updateData({'myVendorRating': vendorRating});
    } catch (e) {
      print(e.toString());
    }

    // update rated item
    if (noOfItems > 0){
      itemRatings.forEach((item) async{
        try {
          // get item id 
          String ratedItemId = await getRatedItemsDocumentId(uid, vendorId, item['itemId']);
          await _ratedItemCollectionReference.document(ratedItemId).updateData({'myItemRating': item['rating']});
        } catch (e) {
          print(e.toString());
        }
      });
    }
  }

  // host it 
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