import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vlads_cards/database/database_service.dart';
import 'package:vlads_cards/repositories/login/facebook_login/facebook_login.dart';

part 'facebook_auth_event.dart';
part 'facebook_auth_state.dart';

class FacebookAuthBloc extends Bloc<FacebookAuthEvent, FacebookAuthState> {
  final FacebookLoginRepository _facebookLoginRepository =
      FacebookLoginRepository();
  final DatabaseService _database = DatabaseService();

  FacebookAuthBloc() : super(FacebookAuthInitial()) {
    on<FacebookSignInEvent>((event, emit) async {
      emit(FacebookAuthProgress());
      try {
        User? firebaseUser =
            await _facebookLoginRepository.signInWithFacebook();
        if (firebaseUser != null) {
          MyUser myUser =
              MyUser(id: firebaseUser.uid, email: firebaseUser.email!);

          await _database.addUser(myUser);
          emit(FacebookAuthSeccuss(myUser: myUser));
        }
      } catch (e) {
        emit(FacebookAuthFailure());
        debugPrint(e.toString());
      }
    });
  }
}
