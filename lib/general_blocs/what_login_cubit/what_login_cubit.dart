import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'what_login_state.dart';

class WhatLoginCubit extends Cubit<WhatLoginState> {
  WhatLoginCubit()
      : super(const WhatLoginState(whatLogin: "initial", inOrUp: "initial"));

  void whatLogin(String whatLogin, String inOrUp) {
    if (whatLogin == "google" && inOrUp == "in") {
      GetIt.I<Talker>().warning(whatLogin);
      emit(const WhatLoginState(whatLogin: "google", inOrUp: 'in'));
    } else if (whatLogin == "email" && inOrUp == "in") {
      GetIt.I<Talker>().warning(whatLogin);
      emit(const WhatLoginState(whatLogin: "email", inOrUp: "in"));
    } else if (whatLogin == "email" && inOrUp == "up") {
      GetIt.I<Talker>().warning(whatLogin);
      emit(const WhatLoginState(whatLogin: "email", inOrUp: "up"));
    } else {
      GetIt.I<Talker>().warning('UNDREFIND');
      emit(const WhatLoginState(whatLogin: "UNDERFIND", inOrUp: "in"));
    }
  }
}
