import 'package:flutter/material.dart';
import 'package:goplus/utils/app_colors.dart';

class AppButton extends StatefulWidget {
  var onTap;
  final String? name;
  final Color color;
  AppButton({this.onTap, this.name, this.color = AppColors.primaryColor});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            highlightColor: Colors.yellow[600],
            onPressed: () => widget.onTap(),
            height: size.height * 0.07,
            minWidth: size.width * 0.9,
            color: AppColors.primaryColor,
            child: Text(
              widget.name!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Anton',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
