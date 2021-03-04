import 'package:bloc/bloc.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/models/theme_model.dart';

class ThemesCubit extends Cubit<ThemeModel>{
  ThemesCubit() : super(ThemeModel(themeData: AppTheme.getBlueTheme));
}