import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase_client.dart';

class UsersClient extends FirebaseClient {
  Future<DocumentSnapshot> findSnapshot(DocumentReference reference) => reference.get();

  Stream<DocumentSnapshot> findSnapshotStream(DocumentReference reference) => reference.snapshots();

  Future<DocumentReference> create(Map<String, dynamic> map) => firestore.collection('users').add(map);

  Future<List<DocumentSnapshot>> fetchFromAttribute(String attributeName, dynamic attributeValue) async {
    Query query = firestore
      .collection('users')
      .where(attributeName, isEqualTo: attributeValue);

    QuerySnapshot snapshot = await query.getDocuments();

    return snapshot.documents;
  }
}
