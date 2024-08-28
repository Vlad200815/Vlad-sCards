import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_change_state.dart';

class ThemeChangeCubit extends Cubit<ThemeChangeState> {
  ThemeChangeCubit()
      : super(const ThemeChangeState(brightness: Brightness.light));

  void setThemeBrightness(Brightness brightness) {
    emit(ThemeChangeState(brightness: brightness));
  }
}
