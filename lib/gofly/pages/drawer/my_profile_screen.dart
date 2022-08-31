import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_models.dart';
import 'package:texi_booking/models/locales_provider_model.dart';
import 'package:texi_booking/pages/drawer/your_ride_screen.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/widgets/app_widgets/app_button.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  Size size;
  final formkey = GlobalKey<FormState>();
  MyProfileModel _localeText;
  File profileImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .myProfileScreen;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: new ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: size.height * 0.29,
              width: size.width,
              color: AppColors.primaryColor,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(left: 15),
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          _localeText.myProfile + "     ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Container()
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[200]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: profileImage == null
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                : Image.file(
                                    profileImage,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pickProfileFile(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            child: Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Evaana Musk",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return _localeText.firstNameError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                          hintText: "John",
                          labelText: _localeText.firstName,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return _localeText.lastNameError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                          hintText: "Deo",
                          labelText: _localeText.lastName,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return _localeText.phoneNumError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "00000 12345",
                          labelText: _localeText.phoneNum,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return _localeText.emailAddressError;
                        }
                        return null;
                      },
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "JohnDeo@gmail.com",
                          labelText: _localeText.emailAddress,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return _localeText.passwordError;
                        }
                        return null;
                      },
                      obscureText: true,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                          hintText: "******",
                          labelText: _localeText.password,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            AppButton(
              name: _localeText.save,
              onTap: () {
                if (formkey.currentState.validate())
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => YourRidesScreen(
                          isPage: true,
                        ),
                      ));
              },
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  void pickProfileFile(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  setState(() {
                    if (pickedFile != null) {
                      profileImage = File(pickedFile.path);
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text("Gellary"),
                onTap: () async {
                  Navigator.pop(context);
                  final result =
                      await picker.getImage(source: ImageSource.gallery);
                  if (result != null) {
                    setState(() {
                      profileImage = File(result.path);
                    });
                  }
                },
              ),
            ],
          );
        });
  }
}
