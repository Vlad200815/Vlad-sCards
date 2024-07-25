part of 'google_auth_bloc.dart';

sealed class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthProgress extends GoogleAuthState {}

final class GoogleAuthSuccess extends GoogleAuthState {
  final MyUser myUser;

  const GoogleAuthSuccess({required this.myUser});

  @override
  List<Object> get props => [myUser];
}

final class GoogleAuthFailure extends GoogleAuthState {
  final String message;

  const GoogleAuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
