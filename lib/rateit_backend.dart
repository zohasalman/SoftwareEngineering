import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> verifyInviteCode(String inviteCode) async {
  return await Firestore.instance.collection('Event').where('InviteCode', isEqualTo: inviteCode).getDocuments();
}

