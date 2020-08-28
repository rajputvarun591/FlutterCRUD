import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<Color> _animationColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  bool isOpened = false;


  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))..addListener(() {setState(() {
    });});
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(begin: 120.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.75, curve: Curves.easeInOut)));
    _animationColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 1.0, curve: Curves.linear)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 3.0,
                0.0,
              ),
              child: Icon(Icons.delete_outline),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 2.0,
                0.0,
              ),
              child: Icon(Icons.delete_outline),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value,
                0.0,
              ),
              child: Icon(Icons.delete_outline),
            ),
            FloatingActionButton(
                backgroundColor: _animationColor.value,
                child: AnimatedIcon(icon: AnimatedIcons.close_menu, progress: _animateIcon),
                onPressed: animate
            ),
          ],
        ),
      ),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
}
