import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'models/session.dart';


Future<List<Session>> fetchPosts(http.Client client) async {
  final response = await client.get('https://devfest-nantes-2018-api.cleverapps.io/sessions');
  return compute(parsePosts, response.body);
}
 
List<Session> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  parsed.map((key, value) => print(value));
  return parsed.map((key, value) => Session.fromJson(value)).toList();
}


class SessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text("Conférence"),
        ),
        body: FutureBuilder<List<Session>>(
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
  final List<Session> sessions;
 
  ListViewSessions({Key key, this.sessions}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: sessions.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, index) {
          return  ListTile(
            title: Text('${sessions[index].titleMobile}'),
          );
        }
      ),
      
    );
  }
}