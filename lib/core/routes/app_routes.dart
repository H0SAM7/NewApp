import 'package:flutter/material.dart';
import 'package:my_visitor/bottom_navigator_bar.dart';
import 'package:my_visitor/features/auth/views/forget_view.dart';
import 'package:my_visitor/features/auth/views/login_view.dart';
import 'package:my_visitor/features/auth/views/register_view.dart';
import 'package:my_visitor/temp/test.dart';

abstract class AppRoutes {
  //     BottomNavigator
  // BottomNavigator.id: (context) => const BottomNavigator(),
  static String? initialRoute = RegisterView.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    //BottomNavigator.id: (context) => const BottomNavigator(),
    //navigation bar #########
   // HomeView.id: (context) => const HomeView(),
   // ScanView.id: (context) => const ScanView(),
    RegisterView.id: (context) => const RegisterView(),
    LoginView.id: (context) => const LoginView(),
        screenTSt.id: (context) => const screenTSt(),
        ForgetView.id: (context) => const ForgetView(),
             //   SplashScreen1.id: (context) => const SplashScreen1(),


  };
}
