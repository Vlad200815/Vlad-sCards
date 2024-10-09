part of 'email_auth_bloc.dart';

sealed class EmailAuthState extends Equatable {
  const EmailAuthState();

  @override
  List<Object> get props => [];
}

final class EmailAuthInitial extends EmailAuthState {}

final class EmailSignInProgressState extends EmailAuthState {}

final class EmailSignInFailureState extends EmailAuthState {}

final class EmailSignInSuccessState extends EmailAuthState {
  final MyEmailUser myEmailUser;

  const EmailSignInSuccessState({required this.myEmailUser});

  @override
  List<Object> get props => [myEmailUser];
}

final class EmailSignUpProgressState extends EmailAuthState {}

final class EmailSignUpFailureState extends EmailAuthState {}

final class EmailSignUpSuccessState extends EmailAuthState {
  final MyUser myUser;

  const EmailSignUpSuccessState({required this.myUser});

  @override
  List<Object> get props => [myUser];
}

final class EmailSignOutSuccessState extends EmailAuthState {}

final class EmailSignOutProgressState extends EmailAuthState {}

final class EmailSignOutFailureState extends EmailAuthState {}
