import 'package:flutter/material.dart';

notification_dialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("FERMER"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  double width = MediaQuery.of(context).size.width;

  // set up the AlertDialog
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0)),
    child: SingleChildScrollView(
      child: Container(
        width: width / 1,
        child: Text('oklm')
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}