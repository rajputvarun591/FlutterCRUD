import 'package:flutter/material.dart';
import 'package:notes/views/profile.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  //height: (orientation == Orientation.portrait) ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.only(left: 20.00, bottom: 10.00),
                  decoration: BoxDecoration(
                    //image: DecorationImage(image: AssetImage("images/drawer3.jpg"), fit: BoxFit.fill),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 10.00, blurRadius: 10.00)]
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.00),
                        Container(
                          width: 100.00,
                          height: 100.00,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50.00)),
                            child: Image.asset("images/rajputvarun591.jpg", fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(height: 10.00),
                        Container(
                          child: Text("Varun Verma", style: TextStyle(color: Colors.white, fontSize: 20.00)),
                        ),
                        SizedBox(height: 5.00),
                        Container(
                          child: Text("rajputvarun591@gmail.com", style: TextStyle(color: Colors.white, fontSize: 15.00)),
                        ),
                      ],
                    ),
                  ),
                );
              },
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    title: Text("Profile", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey)),
                    leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Support", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey)),
                    leading: Icon(Icons.help, color: Theme.of(context).primaryColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("Settings", style: TextStyle(fontSize: 20.00, color: Colors.blueGrey)),
                    leading: Icon(Icons.settings, color: Theme.of(context).primaryColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(10.00),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(text: TextSpan(text: "Version 0.1.3",  style: TextStyle(color: Colors.blueGrey))),
                          RichText(text: TextSpan(text: "@ 2020 ",  style: TextStyle(color: Colors.blueGrey) , children: [
                            TextSpan(text: "MyNotes", style: TextStyle(color: Colors.blue))
                          ]))
                        ],
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
