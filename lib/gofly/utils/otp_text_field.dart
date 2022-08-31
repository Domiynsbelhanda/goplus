import 'package:flutter/material.dart';
import 'package:texi_booking/utils/app_colors.dart';

enum FieldStyle { underline, box }

class OTPTextField extends StatefulWidget {
  /// Number of the OTP Fields
  final int length;

  /// Total Width of the OTP Text Field
  final double width;

  /// Width of the single OTP Field
  final double fieldWidth;

  /// Manage the type of keyboard that shows up
  final TextInputType keyboardType;

  /// The style to use for the text being edited.
  final TextStyle style;

  /// Text Field Alignment
  /// default: MainAxisAlignment.spaceBetween [MainAxisAlignment]
  final MainAxisAlignment textFieldAlignment;

  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Text Field Style for field shape.
  /// default FieldStyle.underline [FieldStyle]
  final FieldStyle fieldStyle;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String> onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String> onCompleted;
  OTPTextField(
      {Key key,
      this.length = 4,
      this.width = 10,
      this.fieldWidth = 30,
      this.keyboardType = TextInputType.number,
      this.style = const TextStyle(fontSize: 20),
      this.textFieldAlignment = MainAxisAlignment.spaceBetween,
      this.obscureText = false,
      this.fieldStyle: FieldStyle.underline,
      this.onChanged,
      this.onCompleted})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  List<Widget> _textFields;
  List<String> _pin;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>.filled(widget.length, null, growable: false);
    _textControllers = List<TextEditingController>.filled(widget.length, null,
        growable: false);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    _textControllers
        .forEach((TextEditingController controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int i) {
    if (_focusNodes[i] == null) _focusNodes[i] = new FocusNode();

    if (_textControllers[i] == null)
      _textControllers[i] = new TextEditingController();

    return Container(
      width: widget.fieldWidth,
      height: widget.fieldWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        cursorColor: Colors.black54,
        style: widget.style,
        focusNode: _focusNodes[i],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide:
                  BorderSide(color: AppColors.primaryColor, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide: BorderSide(color: Colors.black54, width: 0.5)),
          border: widget.fieldStyle == FieldStyle.box
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: widget.fieldWidth,
                    color: AppColors.primaryColor,
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(width: widget.fieldWidth),
                ),
        ),
        onChanged: (String str) {
          if (str.length > 1) {
            _handlePaste(str);
            return;
          }

          // Check if the current value at this position is empty
          // If it is move focus to previous text field.
          if (str.isEmpty) {
            if (i == 0) return;
            _focusNodes[i].unfocus();
            _focusNodes[i - 1].requestFocus();
          }

          // Update the current pin
          setState(() {
            _pin[i] = str;
          });

          // Remove focus
          if (str.isNotEmpty) _focusNodes[i].unfocus();
          // Set focus to the next field if available
          if (i + 1 != widget.length && str.isNotEmpty)
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);

          String currentPin = _getCurrentPin();

          // if there are no null values that means otp is completed
          // Call the `onCompleted` callback function provided
          if (!_pin.contains(null) &&
              !_pin.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted(currentPin);
          }

          // Call the `onChanged` callback function
          widget.onChanged(currentPin);
        },
      ),
    );
  }

  String _getCurrentPin() {
    String currentPin = "";
    _pin.forEach((String value) {
      currentPin += value;
    });
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > widget.length) {
      str = str.substring(0, widget.length);
    }

    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i].text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[widget.length - 1]);

    String currentPin = _getCurrentPin();

    // if there are no null values that means otp is completed
    // Call the `onCompleted` callback function provided
    if (!_pin.contains(null) &&
        !_pin.contains('') &&
        currentPin.length == widget.length) {
      widget.onCompleted(currentPin);
    }

    // Call the `onChanged` callback function
    widget.onChanged(currentPin);
  }
}
