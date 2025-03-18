

import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';

class AdvItem extends StatelessWidget {
  const AdvItem(
      {super.key,

      required this.color,
      required this.image,
      required this.text});

 
 final String image, text;
 final Color color;

  @override
  Widget build(BuildContext context) {
       final size = MediaQuery.of(context).size;
       var padding = MediaQuery.paddingOf(context);
double newheight = size.height - padding.top - padding.bottom;
   // bool isarabic=isArabic(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
              
            ),
          ),
          Positioned(
            top:newheight*-.035,
            left: 0,
            bottom: 10,
            child: Image.asset(
              image,
           height: newheight * .18,
            ),
          ),
          Center(
            child: Padding(
              padding:  EdgeInsets.only(left: size.width*.25),
              child: Text(text,style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: orangeColor
              ),),
            ),
          )
        ],
      ),
    );
  }
}
