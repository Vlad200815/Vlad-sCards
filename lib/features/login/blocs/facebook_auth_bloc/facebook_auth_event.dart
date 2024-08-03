part of 'facebook_auth_bloc.dart';

abstract class FacebookAuthEvent extends Equatable {
  const FacebookAuthEvent();

  @override
  List<Object> get props => [];
}

class FacebookSignInEvent extends FacebookAuthEvent {
  @override
  List<Object> get props => [];
}
