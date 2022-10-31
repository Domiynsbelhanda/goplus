import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/homePage.dart';
import '../services/auth.dart';
import '../utils/app_colors.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';
import '../widget/otp_text_field.dart';

class DriverVerifyNumberScreen extends StatefulWidget {
  String phone;
  DriverVerifyNumberScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<DriverVerifyNumberScreen> {
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 8.0,),

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
                        text: 'Vous n\'avez pas réçu de code?',
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
                    if(otp != null){
                      var data = {
                        'key': "create_user",
                        'action': "rotp",
                        'otp': otp!,
                        'phone': widget.phone,
                        "level": "4"
                      };

                      Provider.of<Auth>(context, listen: false).checkOtp(context, data)
                          .then((value){
                        if(value['code'] == 'KO'){
                          Navigator.pop(context);
                        } else {
                          notification_dialog(
                              context,
                              "Votre compte a été crée, veuillez patienter l'activation de la part de GO FLY.",
                              {'label': "FERMER", "onTap": (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context)
                                        => HomePage()

                                    )
                                );
                              }
                              },
                              20,
                              false);
                        }
                      });
                    }
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
