import 'package:flutter/material.dart';
import 'package:goplus/utils/app_colors.dart';

notification_dialog(BuildContext context, String text, var button) {

  // set up the button
  Widget okButton = TextButton(
    child: Container(
      padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text(
            '${button['label']}',
          style: TextStyle(
            color: Colors.black
          ),
        )
    ),
    onPressed: button['onTap'],
  );

  double width = MediaQuery.of(context).size.width;

  // set up the AlertDialog
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0)),
    child: SizedBox(
      width: width / 1,
      height: width / 1.3,
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
                  color: Colors.green,
                )
              ),
            ),

            SizedBox(height: 16.0),

            okButton
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