import '../models/my_user.dart';

abstract class EmailLoginRepositoryInterface {
  Future<void> signInWithEmail(String email, String password);
  Future<MyUser> signUpWithEmail(MyUser myEmailUser);
  Future<void> signOut();
}
