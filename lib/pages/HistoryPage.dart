import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:toast/toast.dart';

import '../utils/app_colors.dart';
import '../utils/global_variable.dart';

class HistoryPage extends KFDrawerContent {
  HistoryPage({
    Key? key
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryPage();
  }
}

class _HistoryPage extends State<HistoryPage>{

  late Size size;
  final Stream<QuerySnapshot> _coursesStream = FirebaseFirestore.instance.collection('courses').orderBy('uuid', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);

    return Stack(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(48.0)
                  ),
                  child: IconButton(
                    onPressed: widget.onMenuPressed,
                    icon: const Icon(
                      Icons.menu,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 100.0,
              child: SizedBox(
                width: size.width,
                height: size.height - 130,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _coursesStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError){
                        return const Align(
                          alignment: Alignment.center,
                          child: Text(
                              'Something went wrong'
                          ),
                        );
                      }

                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(height: 16.0,),
                              Text(
                                  'Chargement de vos courses...'
                              )
                            ],
                          ),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                          CollectionReference driverCollection = FirebaseFirestore.instance.collection('drivers');
                          if((data['users'] == token)){
                            if(data['status'] != 'create'){
                                return FutureBuilder(
                                    future : driverCollection.doc(data['driver']).get(),
                                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotClient) {

                                      if(snapshotClient.hasError){
                                        return const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              'Something went wrong'
                                          ),
                                        );
                                      }

                                      if(snapshotClient.connectionState == ConnectionState.waiting){
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              CircularProgressIndicator(),
                                              SizedBox(height: 16.0,),
                                              Text(
                                                  'Chargement de vos courses...'
                                              )
                                            ],
                                          ),
                                        );
                                      }

                                      Map<String, dynamic> driver = snapshotClient.data!.data() as Map<String, dynamic>;

                                      if(data['status'] == 'end'){
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0, 1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Course du ${DateFormat('d MMM y, à HH:mm').format(DateTime.parse(data['start_time'].toDate().toString()))}',
                                                      style: const TextStyle(
                                                          color: Colors.black
                                                      ),
                                                    ),

                                                    Text(
                                                      'Chauffeur : ${driver['firstn']} ${driver['lastn']}',
                                                      style: const TextStyle(
                                                          color: Colors.black
                                                      ),
                                                    ),

                                                    Text(
                                                      'Prix : \$ ${data['prix']}',
                                                      style: const TextStyle(
                                                          color: Colors.black
                                                      ),
                                                    ),

                                                    const Text(
                                                      'Status : Course terminée',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                const Icon(
                                                  Icons.verified_outlined,
                                                  color: Colors.green,
                                                  size: 48.0,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0, 1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Course du ${DateFormat('d MMM y, à HH:mm').format(DateTime.parse(data['start_time'].toDate().toString()))}',
                                                    ),

                                                    Text(
                                                      'Chauffeur : ${driver['firstn']} ${driver['lastn']}',
                                                    ),

                                                    Text(
                                                      'Prix : \$ ${data['prix']}',
                                                    )
                                                  ],
                                                ),
                                                // ListTile(
                                                //   title: Text(data['users']),
                                                //   subtitle: Text(data['status']),
                                                // ),

                                                const Icon(
                                                  Icons.verified_outlined,
                                                  color: Colors.green,
                                                  size: 24.0,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return const SizedBox();
                          }
                        }).toList(),
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}