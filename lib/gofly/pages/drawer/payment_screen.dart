import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';

import '../cancel_ride_screen.dart';

class PaymentScreen extends StatefulWidget {
  final bool isPage;
  PaymentScreen({required this.isPage});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final formkey = GlobalKey<FormState>();
  late Size size;

  late PaymentModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .paymentScreen!;
  }

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  _localeText.addCreditCard,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: size.width * 0.38,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(StringValue.SCAN),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text(
                            _localeText.scanCard,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ),
                SizedBox(height: 30.0),
                Text(
                  _localeText.cardHolderName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return _localeText.cardHolderNameError;
                    }
                    return null;
                  },
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: "John Deo",
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  _localeText.cardNum,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return _localeText.cardNumError;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: "**** **** **** 0000",
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Exp.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Exp. date";
                                }
                                return null;
                              },
                              cursorColor: AppColors.primaryColor,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "05/22",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 50.0),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CVV",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "CVV number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.primaryColor,
                              decoration: InputDecoration(
                                hintText: "123",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                AppButton(
                  name: _localeText.save,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CancelRideScreen(),
                          ));
                    }
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
