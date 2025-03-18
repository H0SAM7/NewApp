import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';

class CustomSendButton extends StatelessWidget {
  const CustomSendButton({
    super.key,
    this.onTap,
    required this.label,
    this.width,
    this.color,
    this.txtcolor,
  });
  final void Function()? onTap;
  final String label;
  final double? width;
  final Color? color;
  final Color? txtcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width ?? 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: orangeColor),
            // gradient: LinearGradient(colors: mixColors),
            color: color ?? orangeColor),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: txtcolor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
