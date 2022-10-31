import 'package:flutter/material.dart';
import 'package:goplus/utils/app_colors.dart';

notification_dialog(
    BuildContext context,
    String text,
    IconData? icons,
    Color? color,
    var button,
    double? fontSize,
    bool? barriere) {

  // set up the button
  Widget okButton = TextButton(
    onPressed: button['onTap'],
    child: Container(
      padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text(
            '${button['label']}',
          style: const TextStyle(
            color: Colors.black
          ),
        )
    ),
  );

  double width = MediaQuery.of(context).size.width;

  // set up the AlertDialog
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0)),
    child: Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children : [
            Icon(
              icons,
              color: color,
              size: width / 5,
            ),

            const SizedBox(height: 16.0),

            SizedBox(
              width : width / 1.5,
              height: width / 2.7,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                )
              ),
            ),

            const SizedBox(height: 16.0),

            okButton
          ]
        )
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: barriere!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}