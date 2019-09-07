import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './firebase_client.dart';
import './../models/user.dart';

class UsersClient extends FirebaseClient {
  Future<DocumentSnapshot> fetch(String id) async {
    return firestore.collection('users').document(id).get();
  }

  Future<Query> fetchFromAttribute(String attributeName, dynamic attributeValue) async {
    return firestore
      .collection('users')
      .where(attributeName, isEqualTo: attributeValue);
  }

  Future<DocumentSnapshot> create(Map<String, dynamic> map) async {
    DocumentReference reference = await firestore.collection('users').add(map);

    return reference.get();
  }

  Future<DocumentSnapshot> findFromPhoneNumber() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    Query query = await fetchFromAttribute('phoneNumber', firebaseUser.phoneNumber);

    QuerySnapshot snapshot = await query.getDocuments();
    List<DocumentSnapshot> documents = snapshot.documents;

    if (documents.isEmpty) {
      return create({});
    }

    if (documents.length == 1) {
      return documents[0];
    }

    return null;
  }

  Future<Stream<QuerySnapshot>> currentUserStream() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    Query query= await fetchFromAttribute('phoneNumber', firebaseUser.phoneNumber);

    return query.snapshots();
  }
}
