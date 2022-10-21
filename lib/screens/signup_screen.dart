import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goplus/widget/notification_loader.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';
import '../services/auth.dart';
import '../taxi/screens/verify_number_screen.dart';
import '../utils/app_colors.dart';
import '../widget/app_bar.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';
import 'driver_verify_number_screen.dart';

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
  TextEditingController carPlaqueController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late List input;

  String value = 'h';
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'h', title: 'Homme'),
    S2Choice<String>(value: 'f', title: 'Femme'),
  ];

  String carType = '1';
  List<S2Choice<String>> carTypeoptions = [
    S2Choice<String>(value: '1', title: 'Mini'),
    S2Choice<String>(value: '2', title: 'Berline'),
    S2Choice<String>(value: '3', title: 'Mini Vanne'),
  ];

  String colour = 'Jaune';
  List<S2Choice<String>> colouroptions = [
    S2Choice<String>(value: 'Jaune', title: 'Jaune'),
    S2Choice<String>(value: 'Rouge', title: 'Rouge'),
    S2Choice<String>(value: 'Bleue', title: 'Bleue'),
    S2Choice<String>(value: 'Grise', title: 'Grise'),
    S2Choice<String>(value: 'Noire', title: 'Noire'),
    S2Choice<String>(value: 'Verte', title: 'Verte'),
    S2Choice<String>(value: 'Orange', title: 'Orange'),
    S2Choice<String>(value: 'Blanche', title: 'Blanche'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    input = [
      {
        'label': 'Numéro téléphone',
        'controller' : phoneController,
        'input': TextInputType.phone,
        'max': 9
      },
      {
        'label': 'Mot de passe', 'controller' : passwordController, 'input': TextInputType.visiblePassword
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
        'label': 'Adresse', 'controller' : adresseController, 'input': TextInputType.streetAddress
      },
      {
        'label': 'Ville', 'controller' : villeController
      },
      {
        'label': 'Plaque d\'immatriculation', 'controller' : carPlaqueController
      },
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
                SizedBox(
                  width: size.width,
                  child: const Text(
                    'Inscription Driver',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: size.width * 0.6,
                  child: const Text(
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
                            if(e['max'] != null){
                              return Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.06,
                                    width: size.height * 0.08,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        )),
                                    child: const Text(
                                      "+243",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 1.4,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '${e['label']} incorect';
                                        }
                                        return null;
                                      },
                                      cursorColor: AppColors.primaryColor,
                                      maxLength: e['max'] == null ? null : e['max'],
                                      keyboardType: e['input'] == null ? TextInputType.name : e['input'],
                                      controller: e['controller'],
                                      decoration: InputDecoration(
                                          hintText: '${e['label']}',
                                          contentPadding: EdgeInsets.all(15.0)),
                                    ),
                                  )
                                ],
                              );
                            }
                            return TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '${e['label']} incorect';
                                }
                                return null;
                              },
                              cursorColor: AppColors.primaryColor,
                              maxLength: e['max'] == null ? null : e['max'],
                              keyboardType: e['input'] == null ? TextInputType.name : e['input'],
                              controller: e['controller'],
                              decoration: InputDecoration(
                                  hintText: '${e['label']}',
                                  contentPadding: const EdgeInsets.all(15.0)),
                            );
                          }).toList()
                      ),

                      SmartSelect<String>.single(
                          title: 'Genre',
                          value: value,
                          choiceItems: options,
                          onChange: (state) => setState(() => value = state.value)
                      ),

                      SmartSelect<String>.single(
                          title: 'Type de voiture',
                          value: carType,
                          choiceItems: carTypeoptions,
                          onChange: (state) => setState(() => carType = state.value)
                      ),

                      SmartSelect<String>.single(
                          title: 'Couleur',
                          value: colour,
                          choiceItems: colouroptions,
                          onChange: (state) => setState(() => colour = state.value)
                      ),

                      SizedBox(height: size.height * 0.07),
                      AppButton(
                          name: 'S\'INSRIRE',
                          color: AppColors.primaryColor,
                          onTap: (){
                            if(formkey.currentState!.validate()){
                              notification_loader(context, 'Inscription en cours...', (){});
                              var data = {
                                "key": "create_user",
                                "action": "driver",
                                "lastn": prenomController.text.toString(),
                                "midn": postNomController.text.toString(),
                                "firstn": nameController.text.toString(),
                                "address": adresseController.text.toString(),
                                "password": passwordController.text.trim(),
                                "city": villeController.text.toString(),
                                "phone": phoneController.text.toString(),
                                "gender": value,
                                "cartype": carType,
                                'carplate': carPlaqueController.text.toString(),
                                "colour": colour
                              };

                              Provider.of<Auth>(context, listen: false)
                                  .register(context: context, cred: data).then((res){
                                if(res['code'] == "OTP"){
                                  notification_dialog(
                                      context,
                                      "Cliquez sur Suivant pour vérifiez votre numéro de téléphone.",
                                      Icons.error,
                                      Colors.red,
                                      {'label': 'Suivant', "onTap": (){

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DriverVerifyNumberScreen(
                                                  phone: phoneController.text.trim()
                                              )
                                          ),
                                        );
                                      }},
                                      20,
                                      false);

                                } else if(res['code'] == "NOK"){
                                  notification_dialog(
                                      context,
                                      'Ce numéro est déjà utilisée.',
                                      Icons.error,
                                      Colors.red,
                                      {'label': 'FERMER', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                } else if (res['code'] == "KO"){
                                  notification_dialog(
                                      context,
                                      '${res['message']}',
                                      Icons.error,
                                      Colors.red,
                                      {'label': 'FERMER', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                } else {
                                  notification_dialog(
                                      context,
                                      '${res['message']}',
                                      Icons.error,
                                      Colors.red,
                                      {'label': 'FERMER', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                }
                              });
                            }
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
