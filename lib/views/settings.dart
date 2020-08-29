import 'package:flutter/material.dart';
import 'package:notes/app_theme/app_theme.dart';
import 'package:notes/blocs/theme_bloc/theme_bloc.dart';
import 'package:notes/blocs/theme_bloc/theme_event.dart';
import 'package:notes/services/theme_service.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin{
  List<AnimationController> _animationController;
  ThemeBloc _themeBloc;


  @override
  void initState() {
    _animationController = [
      AnimationController(vsync: this, duration: Duration(milliseconds: 100)),
      AnimationController(vsync: this, duration: Duration(milliseconds: 100)),
      AnimationController(vsync: this, duration: Duration(milliseconds: 100)),
      AnimationController(vsync: this, duration: Duration(milliseconds: 100))
    ];
    super.initState();
    _themeBloc = ThemeBloc(new FakeThemeService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Theme"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.00),
        child: Column(
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.90).animate(CurvedAnimation(parent: _animationController[0], curve: Curves.easeInOut)),
              child: Material(
                animationDuration: Duration(seconds: 1),
                color: AppTheme.getTealTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                    ),
                    padding: EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Icon(Icons.extension, color: AppTheme.getTealTheme.primaryColor),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Text("Teal Theme", style: TextStyle(color: AppTheme.getTealTheme.primaryColor)),
                        ),
                        Expanded(
                            child: Container()
                        ),
                        Visibility(
                            visible: false,
                            child: Container(
                                padding: EdgeInsets.all(10.00),
                                child: Icon(Icons.check)
                            )
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    _animationController[0].repeat(reverse: true);
                    Future.delayed(Duration(milliseconds: 200), (){
                      _themeBloc.add(ChangeTheme(themeName: AppTheme.tealTheme));
                      _animationController[0].stop();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15.00),
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.90).animate(CurvedAnimation(parent: _animationController[1], curve: Curves.easeInOut)),
              child: Material(
                animationDuration: Duration(seconds: 1),
                color: AppTheme.getBlueTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                    ),
                    padding: EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Icon(Icons.color_lens, color: AppTheme.getBlueTheme.primaryColor),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Text("Blue Theme", style: TextStyle(color: AppTheme.getBlueTheme.primaryColor)),
                        ),
                        Expanded(
                            child: Container()
                        ),
                        Visibility(
                            visible: false,
                            child: Container(
                                padding: EdgeInsets.all(10.00),
                                child: Icon(Icons.check)
                            )
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    _animationController[1].repeat(reverse: true);
                    Future.delayed(Duration(milliseconds: 200), (){
                      _themeBloc.add(ChangeTheme(themeName: AppTheme.blueTheme));
                      _animationController[1].stop();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15.00),
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.90).animate(CurvedAnimation(parent: _animationController[2], curve: Curves.easeInOut)),
              child: Material(
                animationDuration: Duration(seconds: 1),
                color: AppTheme.getRedTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                    ),
                    padding: EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Icon(Icons.extension, color: AppTheme.getRedTheme.primaryColor),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Text("Red Theme", style: TextStyle(color: AppTheme.getRedTheme.primaryColor)),
                        ),
                        Expanded(
                            child: Container()
                        ),
                        Visibility(
                            visible: false,
                            child: Container(
                                padding: EdgeInsets.all(10.00),
                                child: Icon(Icons.check)
                            )
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    _animationController[2].repeat(reverse: true);
                    Future.delayed(Duration(milliseconds: 200), (){
                      _themeBloc.add(ChangeTheme(themeName: AppTheme.redTheme));
                      _animationController[2].stop();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15.00),
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.90).animate(CurvedAnimation(parent: _animationController[3], curve: Curves.easeInOut)),
              child: Material(
                animationDuration: Duration(seconds: 1),
                color: AppTheme.getPurpleTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(5.00)),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.00)),
                    ),
                    padding: EdgeInsets.all(10.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Icon(Icons.color_lens, color: AppTheme.getPurpleTheme.primaryColor),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.00),
                          child: Text("Purple Theme", style: TextStyle(color: AppTheme.getPurpleTheme.primaryColor)),
                        ),
                        Expanded(
                            child: Container()
                        ),
                        Visibility(
                            visible: false,
                            child: Container(
                                padding: EdgeInsets.all(10.00),
                                child: Icon(Icons.check)
                            )
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    _animationController[3].repeat(reverse: true);
                    Future.delayed(Duration(milliseconds: 200), (){
                      _themeBloc.add(ChangeTheme(themeName: AppTheme.purpleTheme));
                      _animationController[3].stop();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _themeBloc.close();
  }
}

