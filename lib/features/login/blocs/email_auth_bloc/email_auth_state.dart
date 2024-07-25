part of 'email_auth_bloc.dart';

sealed class EmailAuthState extends Equatable {
  const EmailAuthState();

  @override
  List<Object> get props => [];
}

final class EmailAuthInitial extends EmailAuthState {}

final class EmailSignInProgressState extends EmailAuthState {}

final class EmailSignInFailureState extends EmailAuthState {}

final class EmailSignInSuccessState extends EmailAuthState {}

final class EmailSignUpProgressState extends EmailAuthState {}

final class EmailSignUpFailureState extends EmailAuthState {}

final class EmailSignUpSuccessState extends EmailAuthState {}
