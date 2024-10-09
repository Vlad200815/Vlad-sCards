import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepositoryInterface {
  Future<User?> signInWithGoogle();
  Future<void> googleSignOut();
}
