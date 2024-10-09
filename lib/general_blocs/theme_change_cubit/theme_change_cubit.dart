import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/repositories/settings/settings.dart';

part 'theme_change_state.dart';

class ThemeChangeCubit extends Cubit<ThemeChangeState> {
  ThemeChangeCubit({
    required SettingsRepositoryInterface settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const ThemeChangeState(brightness: Brightness.light)) {
    _checkSelectedTheme();
  }

  final SettingsRepositoryInterface _settingsRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    try {
      emit(ThemeChangeState(brightness: brightness));
      _settingsRepository.setDarkThemeSelected(
        brightness == Brightness.dark,
      );
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  void _checkSelectedTheme() {
    try {
      final brightness = _settingsRepository.isDarkThemeSelected()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeChangeState(brightness: brightness));
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  bool isDark() {
    return _settingsRepository.isDarkThemeSelected();
  }
}
