import 'package:flutter/material.dart';
import 'package:goplus/utils/app_colors.dart';

notification_dialog(
    BuildContext context,
    String text,
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
    child: SizedBox(
      height: width / 1.2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.black,
                      )
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  child: okButton
              ),
            )
          ],
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