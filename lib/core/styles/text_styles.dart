import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  static TextStyle style22White(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: getResponsiveSize(context, fontSize: 22),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle style32(BuildContext context, Color color) {
    return TextStyle(
      color: color,
      fontSize: getResponsiveSize(context, fontSize: 32),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle style18(
    BuildContext context,
  ) {
    return const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 243, 248, 254));
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize

double getResponsiveSize(BuildContext context, {required double fontSize}) {
  double responsiveSize = fontSize * getScaleFactor(context);
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  responsiveSize.clamp(lowerLimit, upperLimit);
  //log(responsiveSize.toString());
  return responsiveSize;
}

double getScaleFactor(BuildContext context) {
  //   var disPacher=PlatformDispatcher.instance;
  // var physicalWidth=disPacher.views.first.physicalSize.width;
  // var devicePixelRatio=disPacher.views.first.devicePixelRatio;
  // double width=physicalWidth/devicePixelRatio;   ------> contextبديل الميديا كويري في حال انك مش عايز تستخدم ال

  double width = MediaQuery.sizeOf(context).width;
  if (width < 750) {
    return width / 450;
  } else if (width < 1200) {
    return width / 800;
  } else {
    return width / 1600;
  }
}
