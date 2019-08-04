import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String phoneNumber;
  String name;

  User(this.phoneNumber, this.name);

  User.fromMap(Map<String, dynamic> map) {
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
      return User.fromMap(snapshot.documents[0].data);
    } else {
      // raise an error here - there should not be more than one user document with the same phone number in the db
    }
    return null;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  bool signedIn() => _googleUser() != null;

  String firstName() => _googleUser().displayName.split(' ')[0];

  String imageUrl() => _googleUser().photoUrl;

  GoogleSignInAccount _googleUser() => _googleSignIn.currentUser;
}
