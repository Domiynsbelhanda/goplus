import 'package:flutter/material.dart';
import 'package:texi_booking/utils/app_colors.dart';

class AppButton extends StatefulWidget {
  final Function onTap;
  final String name;
  final Color color;
  AppButton({this.onTap, this.name, this.color = AppColors.primaryColor});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.035),
            boxShadow: [
              BoxShadow(color: Colors.grey[300], blurRadius: 3, spreadRadius: 1)
            ]),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height * 0.035),
          ),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            highlightColor: Colors.yellow[600],
            onPressed: () => widget.onTap(),
            height: size.height * 0.07,
            minWidth: size.width * 0.9,
            color: AppColors.primaryColor,
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
