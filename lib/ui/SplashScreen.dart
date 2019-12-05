import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, homePage);
  }

  void homePage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white70, Colors.white70]
            )
        ),
        child: Center(
          child: Text(
            "My Notes",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.w900,
                color: Colors.cyan,
                fontSize: 50),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
