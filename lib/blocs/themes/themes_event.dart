import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/enums/enums.dart';

abstract class ThemesEvent extends Equatable{
  const ThemesEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemesEvent{
  final ThemeEnum themeName;

  ChangeTheme({@required this.themeName});
}