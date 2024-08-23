import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/database/database_service.dart';
import 'package:vlads_cards/repositories/login/google_login/google_login.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final LoginRepository _googleAuth = LoginRepository();
  final DatabaseService _database = DatabaseService();
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(GoogleAuthProgress());
      try {
        User? firebaseUser = await _googleAuth.signInWithGoogle();
        if (firebaseUser != null) {
          MyUser myUser = MyUser(
            id: firebaseUser.uid,
            email: firebaseUser.email!,
          );
          await _database.addUser(myUser);
          emit(GoogleAuthSuccess(myUser: myUser));
        }
      } catch (e, st) {
        emit(GoogleAuthFailure(message: e.toString()));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
