import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../pages/homePage.dart';
import '../../utils/app_colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/app_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController postNomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late List input;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    input = [
      {
        'label': 'Numéro téléphone', 'controller' : phoneController
      },
      {
        'label': 'Nom', 'controller' : nameController
      },
      {
        'label': 'PostNom', 'controller' : postNomController
      },
      {
        'label': 'Prénom', 'controller' : prenomController
      },
      {
        'label': 'Adresse', 'controller' : adresseController
      },
      {
        'label': 'Ville', 'controller' : villeController
      },
      {
        'label': 'Genre',
        'controller' : genreController
      },
      {
        'label': 'Type de voiture',
        'controller' : typeController
      }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                APPBAR(),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  width: size.width,
                  child: Text(
                    'Inscription',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: size.width * 0.6,
                  child: Text(
                    'Créer votre compte pour chauffeur.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Column(
                        children: input.map((e){
                          return TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '${e['label']} incorect';
                              }
                              return null;
                            },
                            cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.name,
                            controller: e['controller'],
                            decoration: InputDecoration(
                                hintText: '${e['label']}',
                                contentPadding: EdgeInsets.all(15.0)),
                          );
                        }).toList()
                      ),

                      SizedBox(height: size.height * 0.07),
                      AppButton(
                          name: 'S\'INSRIRE',
                          onTap: (){
                            if(formkey.currentState!.validate()){
                              var data = {
                                "key": "hailing",
                                "action": "create_user",
                                "lastn": nameController.text.toString(),
                                "midn": postNomController.text.toString(),
                                "firstn": prenomController.text.toString(),
                                "address": adresseController.text.toString(),
                                "password": "OdK98@RAM",
                                "city": villeController.text.toString(),
                                "phone": phoneController.text.toString(),
                                "gender": genreController.text.toString(),
                                "profpic": "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                "cartype": typeController.text.toString(),
                                "carpic": "https://firebasestorage.googleapis.com/v0/b/taxigo-e3fcc.appspot.com/o/driver.jpg?alt=media&token=51c634b4-5a95-4607-8f82-27ed1bbb9e05",
                                "level": "4"
                              };
                              FirebaseFirestore.instance.collection('drivers').doc(phoneController.text.toString()).set(data);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
