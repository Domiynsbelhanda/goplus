import 'package:flutter/material.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../utils/app_colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/app_button.dart';
import '../../widget/notification_dialog.dart';
import '../../widget/notification_loader.dart';
import '../../widget/otp_text_field.dart';

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
                APPBAR(),
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
                    notification_loader(context, 'Vérification OTP en cours...', (){});
                    if(otp != null){
                      var data;
                      if(widget.register){
                        data = {
                          'key': "create_user",
                          'action': "rotp",
                          'otp': otp!,
                          'phone': widget.phone,
                          "level": "4"
                        };
                      } else {
                        data = {
                          'key': "check_user",
                          'action': "rotp",
                          'otp': otp!,
                          'phone': widget.phone,
                          "level": "4"
                        };
                      }

                      Provider.of<Auth>(context, listen: false).checkOtp(context, data)
                          .then((value){
                        if(value['code'] == 'KO'){
                          Navigator.pop(context);
                        } else {
                          var checkSid = {
                            'key': "check_user",
                            'action': "sid",
                            'sid': value['sid'],
                            "level": "4"
                          };
                          Provider.of<Auth>(context, listen: false).checkSID(context, checkSid).then(
                                  (sid){

                                if(sid['code'] == 'OK'){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage()
                                    ),
                                  );
                                } else {
                                  notification_dialog(
                                      context,
                                      'Votre compte n\'est pas actif, contactez GO PLUS.',
                                      Icons.error,
                                      Colors.red,
                                      {'label': 'REESAYEZ', "onTap": (){
                                        Navigator.pop(context);
                                      }},
                                      20,
                                      false);
                                }

                              });
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