part of 'email_auth_bloc.dart';

abstract class EmailAuthEvent extends Equatable {
  const EmailAuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailEvent extends EmailAuthEvent {
  final String email;
  final String password;

  const SignInWithEmailEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpWithEmailEvent extends EmailAuthEvent {
  final MyUser myUser;

  const SignUpWithEmailEvent({required this.myUser});

  @override
  List<Object> get props => [myUser];
}

class SignOut extends EmailAuthEvent {}
