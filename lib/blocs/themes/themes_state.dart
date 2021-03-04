import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/models/models.dart';

abstract class ThemesState extends Equatable{
  const ThemesState();

  @override
  List<Object> get props => [];
}

class ThemeInitialState extends ThemesState{}

class ThemeChanged extends ThemesState{
  final ThemeModel theme;

  ThemeChanged({@required this.theme});
}