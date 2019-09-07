import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseClient {
  Firestore get firestore => Firestore.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;
}