import 'package:flutter/material.dart';
import 'sessionspage.dart';
import 'speakerspage.dart';
import 'homepage.dart';
import 'dart:io' show Platform;
import 'package:connectivity/connectivity.dart';

class PhoneInformationPage extends StatelessWidget {

  static final connectivityResult = new Connectivity().checkConnectivity();
  var connectivity = connectivityResult == ConnectivityResult.mobile ? "Mobile" : "Wifi";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: Drawer(
          child: ListView(
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
        ),
        appBar: new AppBar(
          title: new Text("Informations"),
        ),
        body: new Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                
              Container(
                  child: Text(
                    "Plateforme : ${Platform.operatingSystem}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  child: Text(
                    "Version : ${Platform.operatingSystemVersion}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            )));
  }
}
