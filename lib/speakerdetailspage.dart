import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import 'models/speaker.dart';
import 'services/utils.dart' as utils;
import 'globals.dart' as globals;
import 'models/session.dart';
import 'sessionspage.dart';
import 'package:http/http.dart' as http;
import 'sessiondetailspage.dart';
import 'components/roundedbutton.dart';
import 'dart:async';

class SpeakerDetailsPage extends StatefulWidget {
  SpeakerDetailsPage(this.currSpeaker);

  final Speaker currSpeaker;

  @override
  SpeakerDetailsPageState createState() {
    return new SpeakerDetailsPageState();
  }
}

class SpeakerDetailsPageState extends State<SpeakerDetailsPage> {
  List<Session> sessions = [];
  Image image;
  _addContact() async {
    var splitedName = widget.currSpeaker.name.split(" ");
    String firstName = splitedName[0];
    String lastName = splitedName[1];
    Contact newContact = Contact(givenName: firstName, familyName: lastName, company: widget.currSpeaker.company);
    await ContactsService.addContact(newContact);
  }

  @override
  void initState() {
    super.initState();
    image = Image.network("${globals.urlDevfest}/${widget.currSpeaker.avatar}");
    fetchSessions(http.Client()).then((ses) {
      for (Session session in ses) {
        for (int speaker in session.speakers) {
          if (speaker == int.parse(widget.currSpeaker.id)) {
            sessions.add(session);
          }
        }
      }
      setState(() {
        this.sessions = sessions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(widget.currSpeaker.name),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: image,
                ),
                Container(child: Builder(builder: (BuildContext context) {
                  return RoundedButton(
                    text: 'Ajouter aux contacts',
                    func: () async {
                      await _addContact();
                      utils.showToast(context, "Contact ajouté");
                    },
                  );
                })),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Biographie",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(widget.currSpeaker.bio),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Ses présentations",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: this.sessions.length,
                      padding: const EdgeInsets.all(15.0),
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.only(top: 5.0),
                              title: Text('${sessions[index].title}'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SessionDetailsPage(
                                                sessions[index])));
                              },
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ),
              ],
            )));
  }
}
