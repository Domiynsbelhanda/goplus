import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:goplus/screens/user_signup_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../utils/global_variable.dart';
import '../widget/NetworkStatus.dart';
import 'verify_number_screen.dart';
import '../utils/app_colors.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {

  late Size size;
  final formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.08),

                  const Text(
                    'CONNEXION',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0
                    ),
                  ),

                  SizedBox(height: size.height * 0.09,),

                  const Text(
                    'Entrez votre numéro de téléphone',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),
                  SizedBox(height: size.height * 0.05),
                  const Text(
                    'Respectez comme indiqué dans l\'exemple.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
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

                            const SizedBox(width: 10.0,),

                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Numéro de téléphone incorrect';
                                  }
                                  if(value.length != 9){
                                    return 'Numéro de téléphone incorrect, vérifiez.';
                                  }
                                  return null;
                                },
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.primaryColor,
                                controller: phoneController,
                                decoration: const InputDecoration(
                                  hintText: "812345678",
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16.0,),

                        SizedBox(
                          width: size.width,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Entrez un mot de passe valide';
                              }
                              return null;
                            },
                            cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            decoration: const InputDecoration(
                                hintText: 'Mot de passe',
                                contentPadding: EdgeInsets.all(15.0)),
                          ),
                        ),

                        SizedBox(height: size.height * 0.08),
                        AppButton(
                          color: AppColors.primaryColor,
                          name: 'CONNEXION',
                          onTap: () async {
                            if (formkey.currentState!.validate()){
                              showLoader('Connexion en cours\nVeuillez patienter...');
                              var data = {
                                "key": "check_user",
                                "action": "client",
                                "phone": phoneController.text.trim(),
                                "password": passwordController.text.trim()
                              };
                              Provider.of<Auth>(context, listen: false)
                                  .login(context: context, creds: data).then((value){

                                    disableLoader();

                                    if(value['code'] == 'OTP'){

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => VerifyNumberScreen(
                                            register: true,
                                            phone: phoneController.text.trim())
                                    ),
                                  );
                                } else if(value['code'] == 'KO'){
                                      notification_dialog(
                                          context,
                                          "Votre compte n'exsite pas, creez en un.",
                                          {'label': "S'INSCRIRE", "onTap": (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => const UserSignupScreen()
                                              ),
                                            );
                                          }
                                          },
                                          20,
                                          false);
                                    }
                                  else if (value['code'] == 'NOK'){
                                  notification_dialog(
                                      context,
                                      "Coordonée incorrect.",
                                      {'label': "FERMER", "onTap": (){
                                        Navigator.pop(context);
                                      }
                                      },
                                      20,
                                      false);
                                } else if(value['code'] == 'NULL'){
                                  notification_dialog(
                                      context,
                                      'Une erreur c\'est produite. ${value['error']}',
                                      {'label': 'REESAYEZ', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                } else if(value['code'] == 'ERROR'){
                                  notification_dialog(
                                      context,
                                      'Une erreur c\'est produite. ${value['error']}',
                                      {'label': 'FERMER', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                } else {
                                  notification_dialog(
                                      context,
                                      'Une erreur c\'est produite. ${value['error']}',
                                      {'label': 'FERMER', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      true);
                                }
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 16.0,),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const UserSignupScreen()
                              )
                            );
                          },
                          child: const Text(
                            'Pas de compte? Créez en un.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.1),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: FutureBuilder<bool>(
                  future: InternetConnectionChecker().hasConnection,
                  builder: (context, connected) {
                    bool visible = false;
                    if(connected.hasData){
                      visible = !(connected.data!);
                    }
                    return Visibility(
                      visible: visible,
                      child: const InternetNotAvailable(),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
