import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vlads_cards/repositories/login/email_login/email_login_repository_interface.dart';
import '../models/my_user.dart';

class EmailLoginRepository implements EmailLoginRepositoryInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint("Sign out seccessfully");
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        debugPrint('The email address is not valid.');
      } else if (e.code == 'user-disabled') {
        debugPrint('The user account has been disabled.');
      } else if (e.code == 'too-many-requests') {
        debugPrint('Too many sign-in attempts. Please try again later.');
      } else {
        debugPrint('Sign in failed: ${e.message}');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUpWithEmail(MyUser myUser) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: myUser.password!,
      );

      myUser = myUser.copyWith(id: user.user!.uid);

      return myUser;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
