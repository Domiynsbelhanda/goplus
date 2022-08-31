import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';

import 'enter_phone_number_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  late SignupModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .signupScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
                Container(
                  width: size.width * 0.3,
                  child: Text(
                    _localeText.signUp,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: size.width * 0.6,
                  child: Text(
                    _localeText.signUpBody,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return _localeText.fullNameError;
                          }
                          return null;
                        },
                        cursorColor: AppColors.primaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: _localeText.fullName,
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.all(15.0)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return _localeText.emailError;
                          }
                          return null;
                        },
                        cursorColor: AppColors.primaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: _localeText.email,
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.all(15.0)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return _localeText.passwordError;
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                            hintText: _localeText.password,
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.all(15.0)),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return _localeText.confirmPassError;
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                            hintText: _localeText.confirmPass,
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.all(15.0)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.07),
                AppButton(
                    name: _localeText.signUpBtn,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhoneNumberScreen(),
                        ))),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    _localeText.or,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                buildSignUpWithGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center buildSignUpWithGoogle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(size.height * 0.035),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height * 0.035),
          ),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
              onPressed: () {},
              height: size.height * 0.07,
              minWidth: size.width * 0.9,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    StringValue.GOOGLE,
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width * 0.08,
                  ),
                  Text(
                    _localeText.signUpWithGoogle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
