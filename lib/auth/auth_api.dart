import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_shop/db/db.dart';

class Auth {
  final _authInstance = FirebaseAuth.instance;
  final _db = FirestoreDB();

  FirebaseAuth get instance => _authInstance;

  Future<String> registerWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _authInstance
          .createUserWithEmailAndPassword(email: email, password: password);

      _db.createUser(userCredential.user, name: name);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      throw 'An uncaught error';
    }
    return "Error";
  }

  Future<String> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
      return e;
    }
    return 'error';
  }

  Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    print("google user details" + googleUser.toString());

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Create user in database

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    _db.createUser(userCredential.user);
    return "Signed In";
  }
}
