import 'package:flutter/material.dart';
import 'models/session.dart';
import 'speakerspage.dart';
import 'speakerdetailspage.dart';
import 'models/speaker.dart';
import 'components/roundedbutton.dart';
import 'notespage.dart';
import 'globals.dart' as globals;
class SessionDetailsPage extends StatefulWidget {
  SessionDetailsPage(this.currSession);

  final Session currSession;

  @override
  SessionDetailsPageState createState() {
    return new SessionDetailsPageState();
  }
}

class SessionDetailsPageState extends State<SessionDetailsPage> {

  List<Speaker> speakers = [];



  @override
    void initState() {
      // TODO: implement initState
      super.initState();
              
      findSpeakersWithIds(widget.currSession.speakers).then((speakers) {
        setState(() {
          this.speakers = speakers;
        });
      });
    }

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
                    widget.currSession.title,
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(widget.currSession.desc),
                ),
                Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: this.speakers.length,
                      padding: const EdgeInsets.all(15.0),
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                              leading: Image.network('${globals.urlDevfest}/${speakers[index].avatar}', height: 80.0, width: 80.0),
                              title: Text('${speakers[index].name}'),
                              subtitle: Text('${speakers[index].company}'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SpeakerDetailsPage(speakers[index])));
                              },
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ),
              Container(child: 
              RoundedButton(text:'Mes notes', func:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(widget.currSession)));
              }),)
              ],
            )));
  }
}
