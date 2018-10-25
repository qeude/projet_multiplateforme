import 'package:flutter/material.dart';
import './components/roundedbutton.dart';
import 'sessionspage.dart';
import 'speakerspage.dart';
import 'components/sidemenu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: SideMenu(),
        appBar: new AppBar(
          title: new Text("Conférence"),
        ),
        body: new Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image(image: AssetImage("assets/images/logo-imt.jpg")),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Conférence",
                    style: TextStyle(fontSize: 38.0),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("DateDeb"),
                        Text("-"),
                        Text("DateFin"),
                      ],
                    )),
                Container(
                    child: SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                            text: 'Voir les sessions',
                            func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SessionsPage()));
                            }))),
                Container(
                    child: SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                            text: 'Voir les présentateurs',
                            func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpeakersPage()));
                            }))),
              ],
            )));
  }
}
