import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../utils/app_colors.dart';
import '../utils/global_variable.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';
import '../widget/otp_text_field.dart';

class VerifyNumberScreen extends StatefulWidget {
  bool register;
  String phone;
  VerifyNumberScreen({Key? key, required this.phone, required this.register}) : super(key: key);

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumberScreen> {
  late Size size;
  late String code;
  late bool onEditing = false;
  String? otp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.08),
                Text(
                  'Vérification du numéro de téléphone \n+243${widget.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 8.0,),

                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: OTPTextField(
                    fieldStyle: FieldStyle.box,
                    onChanged: (val) {
                      setState(() {
                        otp = val;
                      });
                    },
                    onCompleted: (val) {
                      setState(() {
                        otp = val;
                      });
                    },
                    width: size.width * 0.75,
                    fieldWidth: size.width * 0.16,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                GestureDetector(
                  onTap: (){
                    Provider.of<Auth>(context, listen: false).sendOtp(context, widget.phone);
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Vous n\'avez pas réçu de code? ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'RENVOYEZ',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  name: 'VERIFIEZ',
                  color: AppColors.primaryColor,
                  onTap: () async{
                    showLoader("Vérification OTP en cours\nVeuillez patienter...");
                    if(otp != null){
                      var data;
                      if(widget.register){
                        data = {
                          'key': "create_user",
                          'action': "rotp",
                          'otp': otp!,
                          'phone': widget.phone,
                          "level": "3"
                        };
                      } else {
                        data = {
                          'key': "check_user",
                          'action': "rotp",
                          'otp': otp!,
                          'phone': widget.phone,
                          "level": "3"
                        };
                      }

                      Provider.of<Auth>(context, listen: false).checkOtp(context, data)
                          .then((value){
                        EasyLoading.dismiss();

                        if(value['code'] == 'KO'){
                          notification_dialog(
                              context,
                              'Erreur OTP, veuillez recommencer.',
                              Icons.warning,
                              Colors.yellow,
                              {'label': 'FERMER', "onTap": (){
                                Navigator.pop(context);
                              }},
                              20,
                              false
                          );
                        } else {
                          notification_dialog(
                              context,
                              "Vous êtes connectés.",
                              Icons.verified,
                              Colors.green,
                              {'label': 'SUIVANT', "onTap": (){
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage()
                                  ),
                                        (route)=>false
                                );
                              }},
                              20,
                              false
                          );
                        }
                      });
                    }

                    // var ref = firestore.collection('drivers');
                    // var doc = await ref.doc(widget.phone).get();
                    // if(doc.exists){
                    //   storeToken(token: widget.phone);
                    // }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => doc.exists ? HomePage() : SignupScreen(
                    //       phone: widget.phone,
                    //     ),
                    //   ),
                    // );
                  },
                ),
                SizedBox(height: size.height * 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}