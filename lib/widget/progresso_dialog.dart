import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/utils/app_colors.dart';

import '../pages/google_maps_popylines.dart';
import '../utils/global_variable.dart';

class ProgressoDialog extends StatelessWidget{

  String text;
  ProgressoDialog({super.key, required this.text});

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)
      ),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('drivers')
            .doc(text).collection('courses').doc('courses').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if(data['status'] == 'cancel'){
              return SizedBox(
                width: size.width / 1,
                height: size.width / 1.1,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children : [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.width / 5,
                          ),

                          const SizedBox(height: 16.0),

                          SizedBox(
                            width : size.width / 1.5,
                            child: const Text(
                                'Votre commande a été annulée par le chauffeur.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          TextButton(
                            child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: const Text(
                                  'FERMER',
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                )
                            ),
                            onPressed: (){
                              FirebaseFirestore.instance.collection('drivers').doc(text).collection('courses')
                                  .doc('courses')
                                  .delete();
                            },
                          )
                        ]
                    )
                ),
              );
            } else if (data['status'] == 'accept'){
              return SizedBox(
                width: size.width / 1,
                height: size.width / 1.1,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children : [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: size.width / 4,
                          ),

                          const SizedBox(height: 16.0),

                          SizedBox(
                            width : size.width / 1.5,
                            child: const Text(
                                'Votre commande a été acceptée.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          TextButton(
                            child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: const Text(
                                  'SUIVRE LE CHAUFEUR',
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                )
                            ),
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          GoogleMapsPolylines(
                                            destination: LatLng(data['destination_latitude'], data['destination_longitude']),
                                            origine: LatLng(data['depart_latitude'], data['depart_longitude']),
                                            position: position,
                                            id: text,
                                          )
                                  ),
                                      (Route<dynamic> route) => false
                              );
                            },
                          )
                        ]
                    )
                ),
              );
            }
            else {
              return SizedBox(
                width: size.width / 1,
                height: size.width /1.3,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children : [
                          const Text(
                            'En attente de la réponse',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          TimerCountdown(
                            secondsDescription: 'Secondes',
                            minutesDescription: 'Minutes',
                            timeTextStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                            format: CountDownTimerFormat.minutesSeconds,
                            endTime: DateTime.now().add(
                              const Duration(
                                minutes: 1,
                                seconds: 35,
                              ),
                            ),
                            onEnd: () {
                              FirebaseFirestore.instance.collection('drivers').doc(text).update({
                                'online': true,
                                'ride': false,
                                'ride_view': false
                              });
                              FirebaseFirestore.instance.collection('drivers').doc(text).collection('courses')
                                  .doc('courses')
                                  .update({
                                'status': 'cancel',
                              });
                            },
                          ),

                          TextButton(
                            child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: const Text(
                                  'ANNULER VOTRE COMMANDE',
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                )
                            ),
                            onPressed: (){
                              FirebaseFirestore.instance.collection('drivers').doc(text).update({
                                'online': true,
                                'ride': false,
                                'ride_view': false
                              });
                              FirebaseFirestore.instance.collection('drivers').doc(text).collection('courses')
                                  .doc('courses')
                                  .update({
                                'status': 'cancel',
                              });
                            },
                          ),
                        ]
                    )
                ),
              );
            }
          }

          return Container();
        },
      ),
    );
  }
}