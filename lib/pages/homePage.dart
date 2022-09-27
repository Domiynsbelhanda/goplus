import 'package:flutter/material.dart';
import 'package:goplus/widget/buildTextField.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:goplus/widget/notification_dialog.dart';

import '../formulaire/dashboard.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  late Size size;
  TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoText(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                          'Où Allez-vous?',
                          style: TextStyle(
                              fontSize: size.width / 20,
                              fontFamily: 'Anton'
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                          'Nos taxis vous y conduirons en toute sécurité et convivialité à bord.',
                          style: TextStyle(
                              fontSize: size.width / 25
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                      child: BuildTextField(
                        labelText: 'Entrez votre destination',
                        context: context,
                        keyboardType: TextInputType.text,
                        validator: null,
                        suffixIcon: {
                          'icon': Icons.search,
                          'onTap': (){
                            String? destination = destinationController.text.trim();
                            if(destination.isEmpty){
                              notification_dialog(
                                  context,
                                  'Veuillez tapez le nom du lieu où vous voulez vous rendre.',
                                  Icons.map_outlined,
                                  Colors.blueAccent,
                                  {
                                    'label': 'FERMER',
                                    'onTap': ()=> Navigator.pop(context)
                                  },
                                  20,
                                  false);
                              return;
                            }
                          },
                        },
                        controller: destinationController,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dashboard()
                    )
                  );
                },
                child: Text(
                    'GO FLY SERVICES',
                    style: TextStyle(
                        fontSize: size.width / 20,
                        fontFamily: 'Anton'
                    )
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}