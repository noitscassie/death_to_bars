import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String phoneNumber;
  String name;

  User(this.id, this.phoneNumber, this.name);

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.phoneNumber = map['phoneNumber'];
    this.name = map['name'];
  }

  static Future<User> findOrCreateFromPhoneNumber(String phoneNumber) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('users').where('phoneNumber', isEqualTo: phoneNumber).getDocuments();

    if (snapshot.documents.isEmpty) {
      DocumentReference document = await Firestore.instance.collection('users').add({
        'phoneNumber': phoneNumber
      });

      DocumentSnapshot snapshot = await document.get();

      return User.fromMap(snapshot.data);
    } else if (snapshot.documents.length == 1) {
      DocumentSnapshot document = snapshot.documents[0];
      Map<String, dynamic> data = document.data;
      data['id'] = document.documentID;

      return User.fromMap(snapshot.documents[0].data);
    } else {
      // raise an error here - there should not be more than one user document with the same phone number in the db
    }
    return null;
  }

  Future<void> update(Map<String, dynamic> attrs) async {
    Firestore.instance.collection('users').document(this.id).updateData(attrs);
  }
}
