import 'package:flutter/material.dart';

notification_dialog(BuildContext context, String text) {

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
    child: SizedBox(
      width: width / 1,
      height: width / 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children : [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: width / 5,
            ),

            SizedBox(height: 16.0),

            Container(
              width : width / 1.5,
              child: Text(
                '${text}',
                style: TextStyle(
                  fontSize: width / 15,
                  color: Colors.green
                ),
              ),
            )
          ]
        )
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