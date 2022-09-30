import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:goplus/utils/app_colors.dart';

progresso_dialog(
    BuildContext context,
    String text,) {
  // set up the button
  Widget okButton = TextButton(
    child: Container(
      padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text(
            'ANNULER',
          style: TextStyle(
            color: Colors.black
          ),
        )
    ),
    onPressed: (){
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
      height: width / 1.1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children : [
            TimerCountdown(
              format: CountDownTimerFormat.daysHoursMinutesSeconds,
              endTime: DateTime.now().add(
                Duration(
                  seconds: 35,
                ),
              ),
              onEnd: () {
                Navigator.pop(context);
              },
            ),
            okButton
          ]
        )
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}