import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:flutter/material.dart';

class HaveAccWidget extends StatelessWidget {
  const HaveAccWidget({
    super.key,
    required this.title,
    required this.action,
    this.onPressed,
  });
  final String title;
  final String action;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            title,
            //   textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            action,
            style: TextStyle(color: orangeColor),
          ),
        ],
      ),
    );
  }
}
