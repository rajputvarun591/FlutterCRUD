import 'package:meta/meta.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/models/theme_model.dart';

abstract class ThemeService {
  Future<ThemeModel> getTheme({ @required String themeName});
}

class FakeThemeService extends ThemeService {
  @override
  Future<ThemeModel> getTheme({String themeName}) {
    return AppTheme.getTheme(themeName);
  }

}