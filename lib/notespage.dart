import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;
import 'models/session.dart';
import 'components/roundedbutton.dart';

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
    _getNote();
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
                    child: Builder(
                      builder: (BuildContext context) {
                        return RoundedButton(
                        text: "Enregistrer",
                        func: () {
                          _saveNote();
                          _showToast(context);
                        });
                      }
                    )
                ),
                Container(
                    padding: EdgeInsets.only(top: 24.0),
                    child: new TextField(
                      controller: notesController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    )),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: (_image != null) ? Image.file(_image) : Text(""),
                )
              ],
            )));
  }

  _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currNote = notesController.text;
    await prefs.setString("note${widget.currSession.id}", currNote);
  }

  _getNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = (prefs.getString('note${widget.currSession.id}') ?? "");
    notesController.text = value;
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Notes sauvegardées'),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
