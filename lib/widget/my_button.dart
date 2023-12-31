import 'package:flutter/material.dart';
import 'package:reserve_vol/config.dart';

class MyButton extends StatefulWidget {
  final Function()? onPressed;
  final String? title;
  final Color color;
  final Color textColor;
  final Color? buttonColor;
  final double borderRadius;

  const MyButton({
    super.key,
    this.onPressed,
    this.title,
    this.color = const Color(0xFF0044A5),
    this.textColor = Colors.white,
    this.buttonColor,
    this.borderRadius = 50.0, // Set default border radius
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth(context),
      height: fullHeight(context) * 0.08,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor ?? widget.color,
          elevation: 3,
          foregroundColor: widget.textColor,
          textStyle: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: fontSize10(context) * 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: Text(
          widget.title!,
        ),
      ),
    );
  }
}
