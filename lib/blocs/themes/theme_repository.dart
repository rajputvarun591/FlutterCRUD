import 'package:meta/meta.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/models/theme_model.dart';

abstract class ThemeRepository {
  ThemeModel getTheme({ @required ThemeEnum themeName});
}

class ThemeRepositoryImpl extends ThemeRepository {
  @override
  ThemeModel getTheme({ThemeEnum themeName}) {
    return AppTheme.getTheme(themeName);
  }

}