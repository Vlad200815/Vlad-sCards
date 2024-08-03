import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:vlads_cards/repositories/login/facebook_login/facebook_login_repository_interface.dart';

class FacebookLoginRepository implements FacebookLoginRepositoryInterface {
  @override
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
