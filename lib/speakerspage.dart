import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'models/speaker.dart';
import 'speakerdetailspage.dart';

Future<List<dynamic>> fetchSpeakers(http.Client client) async {
  final response = await client
      .get('https://devfest-nantes-2018-api.cleverapps.io/speakers');
  return compute(parseSpeakers, response.body);
}

List<dynamic> parseSpeakers(String responseBody) {
  final parsed = json.decode(responseBody);
  final list = parsed
      .map((key, value) => MapEntry(key, Speaker.fromJson(value)))
      .values
      .toList();
  return list;
}

Future<List<Speaker>> findSpeakersWithIds(List<dynamic> ids) async {
  List<Speaker> speakers = [];


  await (fetchSpeakers(http.Client()).then((sp) {
    for(Speaker s in sp) {
      for(int id in ids) {
        if (id == int.parse(s.id)) {
          speakers.add(s);
        }
      }
    }
  }));

  return speakers;
}

class SpeakersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Présentateurs"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchSpeakers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewSpeakers(speakers: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListViewSpeakers extends StatelessWidget {
  final List<dynamic> speakers;

  ListViewSpeakers({Key key, this.speakers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: speakers.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text('${speakers[index].name}'),
                  subtitle: Text('${speakers[index].shortBio}'),
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
    );
  }
}
