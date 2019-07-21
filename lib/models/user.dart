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

  bool signedIn() {
    return _googleSignIn.currentUser != null;
  }
}
