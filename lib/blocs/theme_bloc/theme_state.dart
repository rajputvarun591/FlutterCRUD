import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/models/theme_model.dart';

abstract class ThemeState extends Equatable{
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ChangingTheme extends ThemeState {

}

class ThemeChanged extends ThemeState {
  final ThemeModel theme;

  ThemeChanged({@required this.theme});

  @override
  List<Object> get props => [theme];
}

class InitialState extends ThemeState{}