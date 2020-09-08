import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Notes"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kTextTabBarHeight);
}
