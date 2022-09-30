import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:goplus/utils/app_colors.dart';

progresso_dialog(
    BuildContext contexts,
    String text,) {

  double width = MediaQuery.of(contexts).size.width;

  // show the dialog
  showDialog(
    context: contexts,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20.0)),
        child: SizedBox(
          width: width / 1,
          height: width /1.5,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                    Text(
                        'En attente de la réponse',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    TimerCountdown(
                      secondsDescription: 'Secondes',
                      timeTextStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                      format: CountDownTimerFormat.secondsOnly,
                      endTime: DateTime.now().add(
                        Duration(
                          seconds: 35,
                        ),
                      ),
                      onEnd: () {
                        FirebaseFirestore.instance.collection('drivers').doc(text).update({
                          'online': true,
                          'ride': false
                        });
                        FirebaseFirestore.instance.collection('drivers').doc(text).collection('courses')
                            .doc('courses').delete();
                        Navigator.pop(context);
                      },
                    ),

                    TextButton(
                      child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Text(
                            'ANNULER VOTRE COMMANDE',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          )
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance.collection('drivers').doc(text).update({
                          'online': true,
                          'ride': false
                        });
                        FirebaseFirestore.instance.collection('drivers').doc(text).collection('courses')
                        .doc('courses').delete();
                        Navigator.pop(context);
                      },
                    )
                  ]
              )
          ),
        ),
      );
    },
  );
}