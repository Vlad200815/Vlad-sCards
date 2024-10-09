import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/database/database_service.dart';
import 'package:vlads_cards/repositories/login/email_login/email_login_repository.dart';
import 'package:vlads_cards/repositories/login/google_login/google_login.dart';
import 'package:vlads_cards/repositories/login/models/my_user.dart';

part 'email_auth_event.dart';
part 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  final EmailLoginRepository _emailLoginRepository = EmailLoginRepository();
  final DatabaseService _database = DatabaseService();

  EmailAuthBloc() : super(EmailAuthInitial()) {
    on<SignOut>((event, emit) async {
      emit(EmailSignOutProgressState());
      try {
        await _emailLoginRepository.signOut();
        emit(EmailSignOutSuccessState());
      } catch (e, st) {
        emit(EmailSignOutFailureState());
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<SignInWithEmailEvent>((event, emit) async {
      emit(EmailSignInProgressState());
      try {
        await _emailLoginRepository.signInWithEmail(
            event.email, event.password);
        MyEmailUser myEmailUser =
            MyEmailUser(email: event.email, password: event.password);
        emit(EmailSignInSuccessState(myEmailUser: myEmailUser));
      } catch (e, st) {
        emit(EmailSignInFailureState());
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<SignUpWithEmailEvent>((event, emit) async {
      emit(EmailSignUpProgressState());
      try {
        await _emailLoginRepository.signUpWithEmail(event.myUser);
        await _database.addUser(event.myUser);
        emit(EmailSignUpSuccessState(myUser: event.myUser));
      } catch (e) {
        emit(EmailSignUpFailureState());
        debugPrint(e.toString());
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
