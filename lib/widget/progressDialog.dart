import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressDiialog extends StatelessWidget {
  String msg;

  ProgressDiialog({this.msg});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.indigo[600],
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(width: 6),
              Text(msg, style: TextStyle(color: Colors.black, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
