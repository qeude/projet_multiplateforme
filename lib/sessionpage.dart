import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'models/session.dart';
import 'sessiondetailspage.dart';

Future<List<dynamic>> fetchPosts(http.Client client) async {
  final response = await client
      .get('https://devfest-nantes-2018-api.cleverapps.io/sessions');
  return compute(parsePosts, response.body);
}

List<dynamic> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  final list = parsed
      .map((key, value) => MapEntry(key, Session.fromJson(value)))
      .values
      .toList();
  return list;
}

class SessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Sessions"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewSessions(sessions: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListViewSessions extends StatelessWidget {
  final List<dynamic> sessions;

  ListViewSessions({Key key, this.sessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: sessions.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text('${sessions[index].title}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SessionDetailsPage(sessions[index])));
                  },
                ),
                Divider(),
              ],
            );
          }),
    );
  }
}
