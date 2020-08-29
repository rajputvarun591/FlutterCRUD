import 'package:bloc/bloc.dart';
import 'package:notes/models/models.dart';
import 'package:notes/models/theme_model.dart';
import 'package:notes/services/services.dart';
import 'dart:developer' as dev;

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  final ThemeService _themeService;

  ThemeBloc(ThemeService themeService) : assert(themeService != null), _themeService = themeService;


  @override
  // TODO: implement initialState
  ThemeState get initialState => InitialState();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async*{
    if(event is ChangeTheme) {
      yield*  _mapChangeThemeToEvent(event);
    }
  }

  Stream<ThemeState> _mapChangeThemeToEvent(ChangeTheme event) async*{
    yield ChangingTheme();
    try {
      final ThemeModel theme = await _themeService.getTheme(themeName: event.themeName);
      if (theme != null) {
        yield ThemeChanged(theme: theme);
      }
    } catch (e){
      dev.log(e, time: DateTime.now());
    }
  }
}