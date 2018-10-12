import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'globals.dart' as globals;
import './homepage.dart';


Future<Null> main() async {
  globals.cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Projet Multiplateforme',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}