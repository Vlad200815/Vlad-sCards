part of 'facebook_auth_bloc.dart';

sealed class FacebookAuthState extends Equatable {
  const FacebookAuthState();

  @override
  List<Object> get props => [];
}

final class FacebookAuthInitial extends FacebookAuthState {}

final class FacebookAuthProgress extends FacebookAuthState {}

final class FacebookAuthSeccuss extends FacebookAuthState {
  final MyUser myUser;

  const FacebookAuthSeccuss({
    required this.myUser,
  });

  @override
  List<Object> get props => [myUser];
}

final class FacebookAuthFailure extends FacebookAuthState {}
