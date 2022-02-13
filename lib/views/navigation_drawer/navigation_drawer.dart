import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/themes/theme_bloc.dart';
import 'package:notes/blocs/themes/themes_event.dart';
import 'package:notes/blocs/themes/themes_state.dart';
import 'package:notes/database_helper/database_helper.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/enums/enums.dart';
import 'package:notes/models/models.dart';
import 'package:notes/router/constants.dart';
import 'package:package_info/package_info.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // OrientationBuilder(
            //     builder: (context, orientation) {
            //       return Container(
            //         //height: (orientation == Orientation.portrait) ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.height / 2,
            //         padding: EdgeInsets.only(left: 20.00, bottom: 10.00),
            //         decoration: BoxDecoration(
            //           //image: DecorationImage(image: AssetImage("images/drawer3.jpg"), fit: BoxFit.fill),
            //             color: Theme.of(context).primaryColor,
            //             boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 10.00, blurRadius: 10.00)]
            //         ),
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           child: SafeArea(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 SizedBox(height: 30.00),
            //                 Container(
            //                   width: 100.00,
            //                   height: 100.00,
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: Colors.white,
            //                   ),
            //                   child: ClipRRect(
            //                     borderRadius: BorderRadius.all(Radius.circular(50.00)),
            //                     child: Image.asset("images/rajputvarun591.jpg", fit: BoxFit.fill),
            //                   ),
            //                 ),
            //                 SizedBox(height: 10.00),
            //                 Container(
            //                   child: Text("Varun Verma", style: TextStyle(color: Colors.white, fontSize: 20.00)),
            //                 ),
            //                 SizedBox(height: 5.00),
            //                 Container(
            //                   child: Text("rajputvarun591@gmail.com", style: TextStyle(color: Colors.white, fontSize: 15.00)),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            // ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    // ListTile(
                    //   title: Text("Profile", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey)),
                    //   leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
                    //   trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    //   onTap: (){
                    //     Navigator.of(context).pop();
                    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView()));
                    //   },
                    // ),
                    // Divider(height: 2.00),
                    // ListTile(
                    //   title: Text("Support", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey)),
                    //   leading: Icon(Icons.help, color: Theme.of(context).primaryColor),
                    //   trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    //   onTap: (){
                    //     Navigator.of(context).pop();
                    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomWorkSheet()));
                    //   },
                    // ),
                    // Divider(height: 2.00),
                    SwitchListTile(
                      title: Text("Dark Theme", style: theme.textTheme.headline6),
                      secondary: Icon(Icons.settings),
                      value: Theme.of(context).scaffoldBackgroundColor == Color(0xFF333333),
                      onChanged: _onThemeChanged,
                    ),
                    Divider(height: 2.00),
                    ListTile(
                      title: Text("Trash Bin", style: theme.textTheme.headline6),
                      leading: Icon(Icons.delete),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: () async {
                        Navigator.of(context).pop();
                        List<Notes> trash = await DatabaseHelper().getTrashList(Notes.columnDateModified, Order.descending);
                        Navigator.pushNamed(context, RoutePaths.trashBinRoute, arguments: trash);
                      },
                    ),
                    Divider(height: 2.00),
                    ListTile(
                      title: Text("About Us", style: theme.textTheme.headline6),
                      leading: Icon(Icons.info_outline),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: () async {
                        PackageInfo info = await PackageInfo.fromPlatform();
                        Navigator.of(context).pop();
                        showAboutDialog(
                            context: context,
                            applicationVersion: info.version,
                            applicationIcon: Icon(
                              Icons.apps,
                              color: Theme.of(context).primaryColor,
                              size: 30.00,
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.00),
                                child: Text(
                                    ""
                                    "Developer Name",
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.00)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.00, bottom: 5.00),
                                child: Text("Varun Verma", style: TextStyle(color: Colors.blueGrey)),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.00),
                                child: Text("Developer Mail", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.00)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.00, bottom: 5.00),
                                child: Text("rajputvarun591@gmail.com", style: TextStyle(color: Colors.blueGrey)),
                              ),
                            ]);
                      },
                    ),
                    // Divider(height: 2.00),
                    // Container(
                    //   padding: EdgeInsets.all(10.00),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         RichText(text: TextSpan(text: "Version 0.1.3",  style: TextStyle(color: Colors.blueGrey))),
                    //         RichText(text: TextSpan(text: "@ 2020 ",  style: TextStyle(color: Colors.blueGrey) , children: [
                    //           TextSpan(text: "MyNotes", style: TextStyle(color: Colors.blue))
                    //         ]))
                    //       ],
                    //     )
                    // ),
                    // Divider(height: 2.00),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onThemeChanged(bool value) {
    if(value) {
      BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.DARK));
    } else {
      BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(themeName: ThemeEnum.BLUE));
    }
  }
}
