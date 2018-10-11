import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({this.text, this.func});

  final String text;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 24.0),
        child: SizedBox(
            width: double.infinity,
            child: OutlineButton(
              padding: EdgeInsets.all(16.0),
              child: Text(this.text),
              textColor: Colors.blue,
              borderSide: BorderSide(color: Colors.blue),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0)),
              onPressed: this.func,
            )));
  }
}
