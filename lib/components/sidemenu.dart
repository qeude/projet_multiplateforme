import 'package:flutter/material.dart';

import '../homepage.dart';
import '../sessionspage.dart';
import '../speakerspage.dart';
import '../phoneinformationpage.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 50.0),
            children: <Widget>[
              ListTile(
                title: Text('Accueil'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              ListTile(
                title: Text('Sessions'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SessionsPage()));
                },
              ),
              ListTile(
                title: Text('Présentateurs'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SpeakersPage()));
                },
              ),
              ListTile(
                title: Text('Informations'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneInformationPage()));
                },
              ),
            ],
          ),
        );
  }
}