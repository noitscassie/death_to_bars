import 'package:cloud_firestore/cloud_firestore.dart';

import './../clients/users_client.dart';

class User {
  String _id;
  String _phoneNumber;
  String _name;
  String _bio;
  String _profileImageUrl = defaultImageUrl;
  DocumentReference _documentReference;
  static final UsersClient _client = UsersClient();

  User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this._id = snapshot.documentID;
    this._phoneNumber = snapshot.data['phoneNumber'];
    this._name = snapshot.data['name'];
    this._bio = snapshot.data['bio'];
    this._profileImageUrl = snapshot.data['profileImageUrl'] ?? _profileImageUrl;
    this._documentReference = snapshot.reference;
  }

  static Future<DocumentReference> create(Map<String, dynamic> attrs) =>
      _client.create(attrs);

  static Future<DocumentReference> findFromPhoneNumber(
      String phoneNumber) async {
    List<DocumentSnapshot> documents =
        await _client.fetchFromAttribute('phoneNumber', phoneNumber);

    if (documents.isEmpty) {
      return null;
    }

    if (documents.length == 1) {
      return documents[0].reference;
    }

//    todo: raise an error here - phone numbers in the db should be unique

    return null;
  }

  static const String defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/deathtobars.appspot.com/o/userImages%2Fblank-profile-picture-973460_960_720.png?alt=media&token=064b0150-38e7-4755-8dac-516cfda4a9bf';

  static const String defaultImageName =
      'blank-profile-picture-973460_960_720.png';

  bool get completedSignUp => _completedSignUp();

  bool _completedSignUp() {
    return id != null &&
        name != null &&
        phoneNumber != null &&
        bio != null &&
        image != null;
  }

  String get id => this._id;
  String get phoneNumber => this._phoneNumber;
  String get name => this._name;
  String get bio => this._bio;
  String get image => this._profileImageUrl;
  DocumentReference get reference => this._documentReference;

//  todo: extract everything below here userBloc
//  Future<void> updateProfilePicture(File file) async {
//    // TODO: refactor / tidy up this method
//    StorageReference userImageRef =
//        firebaseStorage.ref().child('userImages').child(Uuid().v1());
//    StorageUploadTask task = userImageRef.putFile(file);
//
//    StorageTaskSnapshot snapshot = await task.onComplete;
//
//    // TODO: work out how to delete the old profile picture here - delete method does not seem to be working
//
//    // do not delete the default profile picture
//    // StorageReference oldProfileImage = await firebaseStorage.getReferenceFromUrl(this.profileImageUrl);
//
//    // oldProfileImage.delete();
//    // if (await oldProfileImage.getName() != defaultImageName) {
//    // }
//
//    snapshot.ref.getDownloadURL().then((url) {
//      update({'profileImageUrl': url});
//    });
//  }
}
