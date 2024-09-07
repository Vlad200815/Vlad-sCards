import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlads_cards/repositories/settings/settings.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  final SharedPreferences preferences;

  SettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = "dark_theme_selected";

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
