import 'package:flutter/material.dart';
import 'package:goplus/pages/homePage.dart';

import '../../utils/app_colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/app_button.dart';
import '../../widget/otp_text_field.dart';

class VerifyNumberScreen extends StatefulWidget {
  String phone;
  VerifyNumberScreen({required this.phone});

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumberScreen> {
  late Size size;
  late String code;
  late bool onEditing = false;

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
                  'Vérification du numéro de téléphone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: OTPTextField(
                    fieldStyle: FieldStyle.box,
                    onChanged: (val) {},
                    onCompleted: (val) {},
                    width: size.width * 0.75,
                    fieldWidth: size.width * 0.16,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Center(
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
                SizedBox(height: 20),
                AppButton(
                  name: 'VERIFIEZ',
                  onTap: () async{
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
