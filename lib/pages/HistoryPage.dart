import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:toast/toast.dart';

import '../utils/app_colors.dart';

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
  final Stream<QuerySnapshot> _coursesStream = FirebaseFirestore.instance.collection('courses').snapshots();

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
                          return ListTile(
                            title: Text(data['users']),
                            subtitle: Text(data['status']),
                          );
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