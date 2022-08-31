import 'package:flutter/material.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  late ForgotPasswordModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .forgotPasswordScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                APPBAR(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  // width: size.width * 0.3,
                  child: Text(
                    _localeText.forgetPassTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: size.width * 0.8,
                  child: Text(
                    _localeText.forgotPassBody,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Form(
                  key: formkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return _localeText.enterEmailOrPhoneError;
                      }
                      return null;
                    },
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                        hintText: _localeText.enterEmailOrPhone),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.075,
                ),
                AppButton(
                  name: _localeText.send,
                  onTap: () {
                    formkey.currentState!.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
