import 'package:flutter/material.dart';
import 'package:goplus/screens/user_signup_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../utils/app_colors.dart';
import '../widget/app_bar.dart';
import '../widget/app_button.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              APPBAR(),
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
                          var data = {
                            "key": "check_user",
                            "action": "client",
                            "phone": phoneController.text.trim(),
                            "pass": passwordController.text.trim()
                          };
                          Provider.of<Auth>(context, listen: false).login(context: context, creds: data);
                          // var ref = FirebaseFirestore.instance.collection('drivers');
                          // var doc = await ref.doc(phoneController.text.trim()).get();
                          // if(doc.exists){
                          //   storeToken(token: phoneController.text.trim());
                          // }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => doc.exists ? HomePage(
                          //       phone: phoneController.text.trim(),
                          //     ) : SignupScreen(
                          //       phone: phoneController.text.trim(),
                          //     ),
                          //   ),
                          // );
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
                          ),
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
    );
  }
}
