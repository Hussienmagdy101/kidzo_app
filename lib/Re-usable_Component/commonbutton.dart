import 'package:flutter/material.dart';


class CustomCommonButton extends StatefulWidget {
  CustomCommonButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    this.textStyle,
    this.buttonColor = const Color(0xFF598393),
    this.textColor = Colors.black,
    this.buttonWidth = 0.85,
    this.buttonHeight = 0.07,
    this.textAlign = Alignment.center,
    this.fontSize = 16,
    this.borderSideColor = const Color(0xFF598393),
  });

  void Function()? onPressed;
  String? buttonName;
  TextStyle? textStyle;
  Color? buttonColor;
  Color? borderSideColor;
  Color? textColor;
  num buttonWidth;
  num buttonHeight;
  Alignment textAlign;
  double fontSize;

  @override
  State<CustomCommonButton> createState() => _CustomCommonButtonState();
}

class _CustomCommonButtonState extends State<CustomCommonButton> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.buttonHeight,
      width: MediaQuery.of(context).size.width * widget.buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isButtonPressed = !_isButtonPressed;
          });
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: widget.borderSideColor!,
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            widget.buttonColor,
          ),
        ),
        child: Align(
          alignment: widget.textAlign,
          child: Text(
            widget.buttonName ?? "",
            style: widget.textStyle ??
                TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
          ),
        ),
      ),
    );
  }
}
