import 'package:flutter/material.dart';
import 'package:goplus/gofly/pages/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/pages/drawer/drawer_screen.dart';
import 'package:goplus/gofly/utils/otp_text_field.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';

class VerifyNumberScreen extends StatefulWidget {
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumberScreen> {
  late Size size;
  late String code;
  late bool onEditing = false;

  late VerifyPhoneModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .verifyPhoneScreen!;
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
                  _localeText.verifyPhoneNum,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  width: size.width,
                  child: Text(
                    _localeText.verifyPhoneBody,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
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
                      text: _localeText.didntReciveCode,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: _localeText.resend,
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
                  name: _localeText.verifyBtn,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Dashboard(),
                    ),
                  ),
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
