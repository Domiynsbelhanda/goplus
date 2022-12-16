import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goplus/screens/enter_phone_number_screen.dart';
import 'package:goplus/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:toast/toast.dart';

import '../../utils/app_colors.dart';
import '../../widget/app_button.dart';
import '../utils/global_variable.dart';
import 'verify_number_screen.dart';
import '../widget/notification_dialog.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<UserSignupScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late List input;

  int genreTag = 0;
  List<Map<String, dynamic>> genreOptions = [
    {
      'name': 'Homme',
      'value' : 'H'
    },
    {
      'name': 'Femme',
      'value' : 'F'
    }
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
        'max': 9,
        'obscure': false
      },
      {
        'label': 'Mot de passe',
        'controller' : passwordController,
        'obscure': true
      },
      {
        'label': 'Nom',
        'controller' : nameController,
        'obscure': false
      },
      {
        'label': 'Prénom',
        'controller' : prenomController,
        'obscure' : false
      },
    ];
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: size.width,
                child: const Text(
                  'Inscription',
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
                  'Créer votre compte client.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  obscureText: e['obscure'],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '${e['label']} incorect';
                                    }
                                    return null;
                                  },
                                  cursorColor: AppColors.primaryColor,
                                  maxLength: e['max'],
                                  keyboardType: e['input'] ?? TextInputType.name,
                                  controller: e['controller'],
                                  decoration: InputDecoration(
                                      hintText: '${e['label']}',
                                      contentPadding: const EdgeInsets.all(15.0)),
                                ),
                              )
                            ],
                          );
                        }
                        return TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${e['label']} invalide';
                            }

                            if(e['obscure'] && value.length < 6){
                              return 'Mot de passe trop cours';
                            }
                            return null;
                          },
                          obscureText: e['obscure'],
                          cursorColor: AppColors.primaryColor,
                          maxLength: e['max'],
                          keyboardType: e['input'] ?? TextInputType.name,
                          controller: e['controller'],
                          decoration: InputDecoration(
                              hintText: '${e['label']}',
                              contentPadding: const EdgeInsets.all(15.0)),
                        );
                      }).toList()
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Genre :',
                          style: TextStyle(
                            fontSize: size.width / 25
                          )
                        ),
                        ChipsChoice<int>.single(
                          value: genreTag,
                          onChanged: (val) => setState(() => genreTag = val),
                          choiceItems: C2Choice.listFrom<int, Map<String, dynamic>>(
                            source: genreOptions,
                            value: (i, v) => i,
                            label: (i, v) => v['name'],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.07),
                    AppButton(
                      color: AppColors.primaryColor,
                        name: 'S\'INSRIRE',
                        onTap: (){
                          if(formkey.currentState!.validate()){
                            showLoader("Inscription en cours\nVeuillez patienter...");
                            if(phoneController.text.trim().length != 9){
                              disableLoader();
                              return;
                            }

                            if(passwordController.text.trim().length < 3){
                              disableLoader();
                              return;
                            }

                            var data = {
                              "key": "create_user",
                              "action": "client",
                              "lastn": prenomController.text.toString(),
                              "firstn": nameController.text.toString(),
                              "password": passwordController.text.trim(),
                              "phone": phoneController.text.toString(),
                              "gender": genreOptions[genreTag]['value']
                            };

                            Provider.of<Auth>(context, listen: false)
                                .request(data: data).then((value){
                                  disableLoader();
                                  if(value['code'].toString() == '400'){
                                    notification_dialog(
                                        context,
                                        '${value['message']}',
                                        {'label': 'FERMER', "onTap": (){
                                          Navigator.pop(context);
                                        }},
                                        20,
                                        false);
                                  } else if(value['code'] == "OTP"){
                                    FirebaseFirestore.instance.collection('clients')
                                        .doc(phoneController.text.trim()).set(data);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => VerifyNumberScreen(
                                                password: passwordController.text.trim(),
                                                  register: true,
                                                  phone: phoneController.text.trim())
                                          )
                                      );
                                  } else if(value['code'] == 'KO'){
                                    FirebaseFirestore.instance.collection('clients')
                                        .doc(phoneController.text.trim()).set(data);
                                    notification_dialog(
                                        context,
                                        '${value['message']}',
                                        {'label': 'SUIVANT', "onTap": (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => VerifyNumberScreen(
                                                    password: passwordController.text.trim(),
                                                    register: true,
                                                    phone: phoneController.text.trim())
                                            ),
                                          );
                                        }},
                                        20,
                                        false);
                                  } else {
                                    notification_dialog(
                                        context,
                                        '${value['error']}',
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

              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 16),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const PhoneNumberScreen()
                        )
                    );
                  },
                  child: const Text(
                    'Vous avez un compte? Connectez-vous.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
