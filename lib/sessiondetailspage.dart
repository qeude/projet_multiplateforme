import 'package:flutter/material.dart';
import 'models/session.dart';
import 'speakerspage.dart';
import 'speakerdetailspage.dart';
import 'models/speaker.dart';
import 'components/roundedbutton.dart';
import 'notespage.dart';

class SessionDetailsPage extends StatefulWidget {
  SessionDetailsPage(this.currSession);

  final Session currSession;

  @override
  SessionDetailsPageState createState() {
    return new SessionDetailsPageState();
  }
}

class SessionDetailsPageState extends State<SessionDetailsPage> {

  Speaker speaker;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
   
      findSpeakerWithId(this.widget.currSession.id).then((speaker) {
        setState(() {
                  this.speaker = speaker;
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
                    padding: EdgeInsets.only(top: 24.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                      leading: Image(
                        image: AssetImage("assets/images/profile-pic.png"),
                        height: 80.0,
                        width: 80.0,
                      ),
                      title: Text(this.speaker != null ? this.speaker.name : ""),
                      subtitle: Text(this.speaker != null ? this.speaker.company : ""),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakerDetailsPage(this.speaker)));
                      },
                    )),
              Container(child: 
              RoundedButton(text:'Mes notes', func:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(widget.currSession)));
              }),)
              ],
            )));
  }
}
