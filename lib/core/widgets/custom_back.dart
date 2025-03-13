import 'package:flutter/material.dart';
import 'package:my_visitor/core/utils/assets.dart';

// ignore: must_be_immutable
class CustomBack extends StatelessWidget {
  CustomBack({super.key, this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3), // Button background color
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Image.asset(Assets.iconsBack, color: Colors.white),
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
      ),
    );
  }
}
