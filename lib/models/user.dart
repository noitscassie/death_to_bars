import 'package:google_sign_in/google_sign_in.dart';

class User {
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
