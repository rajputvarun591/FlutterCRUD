import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/blocs/themes/theme_repository.dart';
import 'package:notes/blocs/themes/themes.dart';

class ThemeBloc extends Bloc<ThemesEvent, ThemesState> {
  final ThemeRepository repository;

  ThemeBloc({@required this.repository})
      : assert(repository != null),
        super(ThemeInitialState());

  @override
  Stream<ThemesState> mapEventToState(ThemesEvent event) async* {
    if (event is ChangeTheme) {
      yield* _mapChangeThemeEventToState(event);
    }
  }

  Stream<ThemesState> _mapChangeThemeEventToState(ChangeTheme event) async* {
    final theme = repository.getTheme(themeName: event.themeName);
    yield ThemeChanged(theme: theme);
  }
}
