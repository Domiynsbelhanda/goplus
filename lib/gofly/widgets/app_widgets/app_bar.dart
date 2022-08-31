import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/gofly/utils/strings.dart';

class APPBAR extends StatefulWidget {
  final String? centerTitle;
  final Color? color;
  final bool menu;
  var onTap;
  final bool visiable;

  APPBAR(
      {this.centerTitle,
      this.color,
      this.menu = false,
      this.visiable = true,
      this.onTap});
  @override
  _APPBARState createState() => _APPBARState();
}

class _APPBARState extends State<APPBAR> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.color,
      // decoration: BoxDecoration(
      //     shape: BoxShape.circle,

      //     boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 5)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.menu
              ? Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              : GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
          widget.centerTitle == null
              ? Container(
                  height: 35,
                  width: 40,
                  color: Colors.transparent,
                )
              : Text(
                  widget.centerTitle!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          widget.visiable
              ? widget.menu
                  ? GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        height: 35,
                        width: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: SvgPicture.asset(StringValue.MENU),
                      ),
                    )
                  : Container(
                      height: 35,
                      width: 40,
                      color: Colors.white,
                    )
              : Container(
                  height: 35,
                  width: 40,
                  color: Colors.transparent,
                )
        ],
      ),
    );
  }
}
