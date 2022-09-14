import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:goplus/gofly/pages/select_car_screen.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:intl/intl.dart';
import 'package:goplus/gofly/pages/search_place_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_bar.dart';
import 'package:goplus/gofly/widgets/map_widget.dart';

class SetPickupTimeScreen extends StatefulWidget {
  @override
  _SetPickupTimeScreenState createState() => _SetPickupTimeScreenState();
}

class _SetPickupTimeScreenState extends State<SetPickupTimeScreen> {
  late Size size;
  late DateTime dateTime;
  late Duration duration;
  late SetPickupTimeModel _localeText;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .setPickupTimeScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          MapWidget(),

          ///[AppBar]
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: APPBAR(
              menu: true,
              visiable: false,
            ),
          ),

          /// [my location icon]

          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.5, left: size.width * 0.85),
            height: 55,
            width: 55,
            color: Colors.white,
            child: Icon(
              Icons.my_location,
              size: 32.0,
            ),
          ),

          /// [Schedule a ride]
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      _localeText.scheduleRide,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 15.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(
                              width: 15.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                DateTime? newDateTime =
                                    await showRoundedDatePicker(
                                  theme: ThemeData(
                                    accentColor: AppColors.primaryColor,
                                    primaryColor: AppColors.primaryColor,
                                    buttonColor: AppColors.primaryColor,
                                    buttonTheme: ButtonThemeData(
                                        buttonColor: Colors.red),
                                  ),
                                  initialDatePickerMode: DatePickerMode.day,
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 2,
                                );
                                if (newDateTime != null)
                                  setState(() => dateTime = newDateTime);
                              },
                              child: Text(
                                  "${DateFormat.E().format(dateTime)}, ${DateFormat.d().format(dateTime).toString()} ${DateFormat.MMM().format(dateTime)}"),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, top: 5),
                          color: Colors.black38,
                          height: 0.5,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.adjust),
                            SizedBox(
                              width: 15.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                TimeOfDay? newTime = await showRoundedTimePicker(
                                    theme: ThemeData(
                                      accentColor: AppColors.primaryColor,
                                      primaryColor: AppColors.primaryColor,
                                    ),
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    leftBtn: "NOW",
                                    onLeftBtn: () {
                                      Navigator.of(context)
                                          .pop(TimeOfDay.now());
                                    });
                                if (newTime != null) {
                                  setState(() {
                                    dateTime = DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      newTime.hour,
                                      newTime.minute,
                                    );
                                  });
                                }
                              },
                              child: Text(
                                  "${DateFormat.jm().format(dateTime)}-${DateFormat.jm().format(dateTime)}"),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, top: 5),
                          color: Colors.black38,
                          height: 0.5,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  AppButton(
                    name: _localeText.setPickupTime,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectCarScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
