import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/database/database_service.dart';
import 'package:vlads_cards/repositories/login/email_login/email_login_repository.dart';
import 'package:vlads_cards/repositories/login/models/my_user.dart';

part 'email_auth_event.dart';
part 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  final EmailLoginRepository _emailLoginRepository = EmailLoginRepository();
  final DatabaseService _database = DatabaseService();

  EmailAuthBloc() : super(EmailAuthInitial()) {
    on<SignOut>((event, emit) async {
      await _emailLoginRepository.signOut();
    });

    on<SignInWithEmailEvent>((event, emit) async {
      emit(EmailSignInProgressState());
      try {
        await _emailLoginRepository.signInWithEmail(
            event.email, event.password);

        emit(EmailSignInSuccessState());
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
        emit(EmailSignUpSuccessState());
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
