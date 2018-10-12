import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';


import 'globals.dart' as globals;
import 'models/session.dart';
import 'components/roundedbutton.dart';
import 'camerapage.dart';

class NotesPage extends StatefulWidget {
  final Session currSession;

  NotesPage(this.currSession);
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final notesController = TextEditingController();
  var imagePath;

  @override
  void initState() {
    super.initState();
    print(globals.cameras);
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Mes notes"),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _navigateCamera(context);
                      },
                      iconSize: 60.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.photo,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                      iconSize: 60.0,
                    )
                  ],
                ),
                Container(
                  child: Text(
                    '${widget.currSession.title}',
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
                Container(
                    child: RoundedButton(text: "Enregistrer", func: () {})),
                Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: new TextField(
                      controller: notesController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    )),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: (imagePath != null) ? Image.file(File(imagePath)): Text(""),
                )
              ],
            ))
        );
  }

  _navigateCamera(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraPage()));

    setState(() {
      imagePath = result;
    });
  }
}