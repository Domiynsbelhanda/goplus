import 'package:flutter/material.dart';
import 'package:goplus/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../../utils/app_colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/app_button.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<UserSignupScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController postNomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late List input;

  String value = 'H';
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'h', title: 'Homme'),
    S2Choice<String>(value: 'f', title: 'Femme'),
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
        'label': 'Numéro téléphone', 'controller' : phoneController, 'input': TextInputType.phone
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
                    'Créer votre compte pour utilisateur.',
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
                            keyboardType: e['input'] == null ? TextInputType.name : e['input'],
                            controller: e['controller'],
                            decoration: InputDecoration(
                                hintText: '${e['label']}',
                                contentPadding: EdgeInsets.all(15.0)),
                          );
                        }).toList()
                      ),

                      SmartSelect<String>.single(
                          title: 'Genre',
                          value: value,
                          choiceItems: options,
                          onChange: (state) => setState(() => value = state.value)
                      ),

                      SizedBox(height: size.height * 0.07),
                      AppButton(
                          name: 'S\'INSRIRE',
                          onTap: (){
                            if(formkey.currentState!.validate()){
                              var data = {
                                "key": "create_user",
                                "action": "client",
                                "lastn": prenomController.text.toString(),
                                "midn": postNomController.text.toString(),
                                "firstn": nameController.text.toString(),
                                "address": adresseController.text.toString(),
                                "password": passwordController.text.trim(),
                                "city": villeController.text.toString(),
                                "phone": phoneController.text.toString(),
                                "gender": value
                              };

                              Provider.of<Auth>(context, listen: false).register(context: context, cred: data);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => HomePage(),
                              //   ),
                              // );
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
