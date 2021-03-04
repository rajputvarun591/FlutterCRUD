import 'package:bloc/bloc.dart';

class ThemeCubitObserver extends BlocObserver{

  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    print("ThemeCubitObserver Created $cubit");
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print("ThemeCubitObserver Closed $cubit");
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print("ThemeCubitObserver Changed $cubit $change");
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    print("ThemeCubitObserver Error $cubit  $error $stackTrace");
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("ThemeCubitObserver Event $bloc $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("ThemeCubitObserver Transition $bloc $transition");
  }
}