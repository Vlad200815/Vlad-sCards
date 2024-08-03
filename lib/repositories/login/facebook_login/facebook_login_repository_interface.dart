import 'package:firebase_auth/firebase_auth.dart';

abstract class FacebookLoginRepositoryInterface {
  Future<User?> signInWithFacebook();
}
