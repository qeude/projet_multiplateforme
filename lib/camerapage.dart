import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'globals.dart' as globals;

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Direction de caméra inconnue');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  String imagePath;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(globals.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text("Photo mes notes"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: _cameraPreviewWidget(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            _captureControlRowWidget(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _cameraTogglesRowWidget(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Choisir une caméra',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return new AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: new CameraPreview(controller));
    }
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          iconSize: 50.0,
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (globals.cameras.isEmpty) {
      return const Text('Aucune caméra trouvée');
    } else {
      for (CameraDescription cameraDescription in globals.cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: onNewCameraSelected,
            ),
          ),
        );
      }
    }
    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          print('Picture saved to $filePath');
          controller.dispose();
          Navigator.pop(context, filePath);
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/projet_multiplateforme';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
