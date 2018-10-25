import 'package:flutter/material.dart';
import 'components/sidemenu.dart';
import 'dart:io' show Platform;
import 'package:connectivity/connectivity.dart';

class PhoneInformationPage extends StatelessWidget {

  static final connectivityResult = new Connectivity().checkConnectivity();
  var connectivity = connectivityResult == ConnectivityResult.mobile ? "Mobile" : "Wifi";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: SideMenu(),
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
