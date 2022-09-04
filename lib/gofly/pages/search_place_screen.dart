import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/pages/select_car_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';

class SearchPlaceScreen extends StatefulWidget {
  @override
  _SearchPlaceScreenState createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  late Size size;
  final formkey = GlobalKey<FormState>();

  late SearchPlaceModel _localeText;
  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .searchPlaceScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          _localeText.searchPlaceText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.my_location,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                              hintText: _localeText.whereYouGo,
                              suffixIcon: Container(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  StringValue.RIGHTARROW,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _localeText.yourPlace,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.my_location,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        _localeText.home,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return _localeText.homeAddressError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: _localeText.homeAddress,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.business_center,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        _localeText.office,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return _localeText.officeAddressError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: _localeText.officeAddress,
                      ),
                    ),
                  ),
                  // SizedBox(height: size.height * 0.03),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         _localeText.addPlace,
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 22.0,
                  //         ),
                  //       ),
                  //     ),
                  //     Icon(
                  //       Icons.my_location,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: size.height * 0.03),
                  // Container(
                  //   height: 50,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //       color: Color(0xfff4f4f4)),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(Icons.search),
                  //       hintText: _localeText.searchPlaceHere,
                  //       border: InputBorder.none,
                  //       contentPadding: EdgeInsets.all(15.0),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 30.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "9 N. Deerfield St. Moses Lake, WA 98837",
                  //         overflow: TextOverflow.ellipsis,
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //     Icon(
                  //       Icons.location_on,
                  //       color: Colors.grey,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 15.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "820 Lawrence Lane Carmel, Ny 1051",
                  //         overflow: TextOverflow.ellipsis,
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //     Icon(
                  //       Icons.location_on,
                  //       color: Colors.grey,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 15.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "09 Brown St. South Richmmond Hill, NY 11419",
                  //         overflow: TextOverflow.ellipsis,
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //     Icon(
                  //       Icons.location_on,
                  //       color: Colors.grey,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: size.height * 0.06),
                  // AppButton(
                  //   name: _localeText.savePlace,
                  //   onTap: () {
                  //     if (formkey.currentState!.validate()) {
                  //       FocusScope.of(context).unfocus();
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => SelectCarScreen(),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
