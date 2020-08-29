import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final String themeName;

  ChangeTheme({@required this.themeName});

  @override
  List<Object> get props => [themeName];
}