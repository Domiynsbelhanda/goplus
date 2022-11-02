import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../services/auth.dart';
import '../utils/app_colors.dart';
import '../utils/global_variable.dart';
import '../widget/NetworkStatus.dart';
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
    ToastContext().init(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                      var data = {
                        "key": "create_user",
                        "action": "otp",
                        "phone": widget.phone
                      };
                      Provider.of<Auth>(context, listen: false).request(data: data).then((value){
                        Toast.show('Code OTP envoyé', duration: Toast.lengthLong, gravity: Toast.bottom);
                      });
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

                        Provider.of<Auth>(context, listen: false).request(data: data)
                            .then((value){

                          disableLoader();

                          if(value['code'] == 'KO'){
                            notification_dialog(
                                context,
                                'Erreur OTP, veuillez recommencer.',
                                {'label': 'FERMER', "onTap": (){
                                  Navigator.pop(context);
                                }},
                                20,
                                false
                            );
                          } else {
                            storage.write(key: 'sid', value: value['sid']);
                            storage.write(key: 'token', value: data['phone']);
                            notification_dialog(
                                context,
                                "Vous êtes connectés.",
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
                    },
                  ),
                  SizedBox(height: size.height * 0.2),
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