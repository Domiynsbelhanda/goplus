import 'package:flutter/material.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';

import 'verify_number_screen.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  late EnterPhoneModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .enterPhoneScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                APPBAR(),
                SizedBox(height: size.height * 0.08),
                Text(
                  _localeText.enterPhoneNum,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  _localeText.enterPhoneBody,
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  _localeText.enterPhoneNumTwo,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.06,
                      width: size.height * 0.06,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: AppColors.primaryColor,
                      )),
                      child: Text(
                        "+243",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                        child: Form(
                      key: formkey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return _localeText.phoneNumError;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          hintText: "00011 10001",
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                AppButton(
                  name: _localeText.sendCode,
                  onTap: () {
                    if (formkey.currentState!.validate())
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VerifyNumberScreen(),
                          ));
                  },
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
