part of 'what_login_cubit.dart';

class WhatLoginState extends Equatable {
  final String whatLogin;
  final String inOrUp;
  const WhatLoginState({required this.whatLogin, required this.inOrUp});

  @override
  List<Object> get props => [whatLogin, inOrUp];
}
