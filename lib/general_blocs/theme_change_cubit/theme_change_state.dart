part of 'theme_change_cubit.dart';

class ThemeChangeState extends Equatable {
  const ThemeChangeState({
    required this.brightness,
  });

  final Brightness brightness;

  @override
  List<Object> get props => [brightness];
}
