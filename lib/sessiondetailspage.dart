import 'package:flutter/material.dart';
import 'models/session.dart';

class SessionDetailsPage extends StatelessWidget {
  SessionDetailsPage(this.currSession);

  final Session currSession;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Sessions"),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: Text(
                    currSession.title,
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(currSession.desc),
                ),
                Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                      leading: Image(
                        image: AssetImage("assets/images/profile-pic.png"),
                        height: 80.0,
                        width: 80.0,
                      ),
                      title: Text('Nom du présentateur'),
                      subtitle: Text('Entrepise du présentateur'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {},
                    ))
              ],
            )));
  }
}
