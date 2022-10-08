import 'package:flutter/material.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../utils/app_colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/app_button.dart';
import '../../widget/notification_loader.dart';
import '../../widget/otp_text_field.dart';

class VerifyNumberScreen extends StatefulWidget {
  String phone;
  VerifyNumberScreen({Key? key, required this.phone}) : super(key: key);

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

                FutureBuilder(
                    future: Provider.of<Auth>(context, listen: false).sendOtp(context, widget.phone),
                    builder: (context, snapshot){

                      if(snapshot.data == 'OK'){
                        return Container(
                          width: size.width,
                          child: const Text(
                            'Vous avez 2 minutes pour confirmer votre numéro.',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: size.width,
                        child: GestureDetector(
                          onTap: (){
                            notification_loader(context, (){});
                            Provider.of<Auth>(context, listen: false).sendOtp(context, widget.phone).then((value){
                              if(value == 'KO'){
                                Navigator.pop(context);
                              } else {

                              }
                            });
                          },
                          child: const Text(
                            'CLIQUEZ ICI POUR ENOVYEZ LE CODE',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      );
                    }
                ),

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
                  onTap: () async{
                    notification_loader(context, (){});
                    if(otp != null){
                      var data = {
                        'key': "rotp",
                        'code': otp!,
                        'phone': widget.phone
                      };

                      Provider.of<Auth>(context, listen: false).checkOtp(context, data)
                      .then((value){
                          if(value == 'KO'){
                            Navigator.pop(context);
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
