import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';



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
  var _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

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
                        getImage(ImageSource.camera);
                      },
                      iconSize: 60.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.photo,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
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
                  child: (_image != null) ? Image.file(_image): Text(""),
                )
              ],
            ))
        );
  }
}
