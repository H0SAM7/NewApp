import 'package:my_visitor/constants.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 20,
      width: 100,
      child: Row(
        children: [
          Container(
            height: 2,
            width: 30,
            color: orangeColor,
          ),
          Text(
            "OR",
            style: TextStyle(color: orangeColor),
          ),
          Container(
            height: 2,
            width: 30,
            color: orangeColor,
          )
        ],
      ),
    );
  }
}
