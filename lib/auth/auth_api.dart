import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/user_model.dart';

class Auth {
  final _authInstance = FirebaseAuth.instance;
  final _db = FirestoreDB();

  FirebaseAuth get instance => _authInstance;

  Future<String> registerWithEmail(String email, String password) async {
    AppUser user = AppUser();
    try {
      UserCredential userCredential = await _authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
          user.id = userCredential.user.uid;
          user.email = email;
      await _db.createUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> signInWithEmail(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email,
              password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return('Wrong password provided for that user.');
      }
    }
  }
}
