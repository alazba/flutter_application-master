import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/profile_controller.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Drawer(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton.icon(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff3d619b),
                ),
                onPressed: () => Navigator.pop(context),
                label: Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                        color: Colors.transparent)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/Login');
              },
              child: buildMenuItem(
                Icons.person,
                S.of(context).guest,
                opacity: 1.0,
                color: Color(0xff3d619b),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 2);
              },
              child: buildMenuItem(
                Icons.home,
                S.of(context).home,
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 3);
              },
              child: buildMenuItem(
                Icons.local_mall,
                S.of(context).my_orders,
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 0);
              },
              child: buildMenuItem(
                Icons.favorite,S.of(context).favorite_products,
              ),),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 0);
              },
              child: buildMenuItem(
                Icons.notifications,
                S.of(context).notifications,
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/Settings');
                } else {
                  Navigator.of(context).pushReplacementNamed('/Login');
                }
              },
              child: buildMenuItem(
                Icons.settings,
                S.of(context).settings,
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  logout().then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) => false, arguments: 2);
                  });
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              child: buildMenuItem(
                Icons.exit_to_app,
                currentUser.value.apiToken != null
                    ? S.of(context).log_out
                    : S.of(context).login,
              ),
            ),
            Divider()
          ],
        ),
      )
      ),
    );
  }

  Opacity buildMenuItem(IconData icon, String title,
      {double opacity = 0.3, Color color = Colors.black}) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Icon(
              icon,
              size: 30.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
