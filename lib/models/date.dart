import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore firestore = Firestore.instance;

class Date {
  String id;
  String proposerId;
  String matchId;
  String description;

  Date(this.id, this.proposerId, this.matchId, this.description);

  Date.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.proposerId = map['proposerId'];
    this.matchId = map['matchId'];
    this.description = map['description'];
  }

  static Future<Date> create(Map<String, dynamic> map) async {
    DocumentReference document = await firestore.collection('dates').add(map);

    DocumentSnapshot snapshot = await document.get();

    return Date.fromMap(snapshot.data);
  }
}
