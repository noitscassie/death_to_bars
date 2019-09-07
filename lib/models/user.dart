import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import './../clients/users_client.dart';

final Firestore firestore = Firestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
final StorageReference userImagesStorageReference = firebaseStorage.ref().child('userImages');
final UsersClient _client = UsersClient();

class User {
  String id;
  String phoneNumber;
  String name;
  String bio;
  String profileImageUrl = defaultImageUrl;

  User(this.id, this.phoneNumber, this.name, this.bio, this.profileImageUrl);

  User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.phoneNumber = snapshot.data['phoneNumber'];
    this.name = snapshot.data['name'];
    this.bio = snapshot.data['bio'];
    this.profileImageUrl = snapshot.data['profileImageUrl'] ?? profileImageUrl;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.phoneNumber = map['phoneNumber'];
    this.name = map['name'];
    this.bio = map['bio'];
    this.profileImageUrl = map['profileImageUrl'] ?? profileImageUrl;
  }

  static const String defaultImageUrl = 'https://firebasestorage.googleapis.com/v0/b/deathtobars.appspot.com/o/userImages%2Fblank-profile-picture-973460_960_720.png?alt=media&token=064b0150-38e7-4755-8dac-516cfda4a9bf';

  static const String defaultImageName = 'blank-profile-picture-973460_960_720.png';

  static Future<User> findOrCreateFromPhoneNumber(String phoneNumber) async {
    Future<QuerySnapshot> futureSnapshot = _client.fetchFromAttribute(
      'phoneNumber',
      phoneNumber
    ).then((Query query) {
      return query.getDocuments();
    });

    QuerySnapshot snapshot = await futureSnapshot;

    if (snapshot.documents.isEmpty) {
      return User.create({
        'phoneNumber': phoneNumber,
        'profileImageUrl': defaultImageUrl,
      });
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

  static Future<User> create(Map<String, dynamic> map) async {
    DocumentReference document = await firestore.collection('users').add(map);

    DocumentSnapshot snapshot = await document.get();

    return User.fromMap(snapshot.data);
  }

  static Future<User> find(String id) async {
    DocumentSnapshot ds = await firestore.collection('users').document(id).get();
    return User.fromMap(ds.data);
  }

  Future<void> update(Map<String, dynamic> attrs) async {
    this.id = attrs['id'] ?? this.id;
    this.name = attrs['name'] ?? this.name;
    this.phoneNumber = attrs['phoneNumber'] ?? this.phoneNumber;
    this.bio = attrs['bio'] ?? this.bio;
    this.profileImageUrl = attrs['profileImageUrl'] ?? this.profileImageUrl;

    firestore.collection('users').document(this.id).updateData(attrs);
  }

  Future<void> updateProfilePicture(File file) async {
    // TODO: refactor / tidy up this method
    StorageReference userImageRef = firebaseStorage.ref().child('userImages').child(Uuid().v1());
    StorageUploadTask task = userImageRef.putFile(file);

    StorageTaskSnapshot snapshot = await task.onComplete;

    // TODO: work out how to delete the old profile picture here - delete method does not seem to be working

    // do not delete the default profile picture
    // StorageReference oldProfileImage = await firebaseStorage.getReferenceFromUrl(this.profileImageUrl);

    // oldProfileImage.delete();
    // if (await oldProfileImage.getName() != defaultImageName) {
    // }

    snapshot.ref.getDownloadURL().then((url) {
      update({ 'profileImageUrl': url});
    });
  }

  Stream<DocumentSnapshot> stream() {
    return firestore.document('/users/${this.id}').snapshots();
  }
}
