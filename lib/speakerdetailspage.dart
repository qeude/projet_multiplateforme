import 'package:flutter/material.dart';
import 'models/speaker.dart';
import 'globals.dart' as globals;
class SpeakerDetailsPage extends StatelessWidget {
  SpeakerDetailsPage(this.currSpeaker);

  final Speaker currSpeaker;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Présentateur"),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: Text(
                    currSpeaker.name,
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
                Container(
                  child: Image.network("${globals.urlDevfest}/${currSpeaker.avatar}"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text("Biographie", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(currSpeaker.bio),
                ),
                 Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text("Ses présentations", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                ),
                Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: ListTile(
                      title: Text('Présentation 1'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {},
                    )),
                    Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: ListTile(
                      title: Text('Présentation 2'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {},
                    ))
              ],
            )));
  }
}
