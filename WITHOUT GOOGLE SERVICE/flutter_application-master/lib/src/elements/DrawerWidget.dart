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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton.icon(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF015FFF),
                ),
                onPressed: () => Navigator.pop(context),
                label: Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                        color: Colors.transparent)),
              ),
            ),
            buildMenuItem(Icons.person, S.of(context).guest,

                opacity: 1.0, color: Color(0xFF015FFF)),
            Divider(),
            buildMenuItem(Icons.home, S.of(context).home,),
            Divider(),
            buildMenuItem(Icons.local_mall, S.of(context).my_orders,),
            Divider(),
            buildMenuItem(Icons.settings, S.of(context).settings,),
            Divider(),
            buildMenuItem(Icons.notifications, S.of(context).notifications,),
            Divider(),
            buildMenuItem(Icons.exit_to_app, currentUser.value.apiToken != null ? S.of(context).log_out : S.of(context).login,
            ),
            Divider()
          ],
        ),
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
              height: 20.0,
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