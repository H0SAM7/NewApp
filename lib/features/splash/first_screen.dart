import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor/bottom_navv_bar.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/core/widgets/crash_view.dart';
import 'package:my_visitor/features/auth/screens/login_view.dart';
import 'package:my_visitor/features/auth/screens/register_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/product_details.dart';
import 'package:my_visitor/core/services/read_crash_value.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  static String id = 'FirstScreen';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () async {
          bool isCrashed = await readCrash();
          bool relogin = await readRelogin();
          if (isCrashed) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog2(
                  title: '',
                  content:
                      'يتم اجراء بعض اعمال الصيانة الرجاء المحاولة لاحقا سيتم اعادة تشغيل الخدمة في اقرب وقت',
                  onConfirm: () {
                    Navigator.pushNamed(context, CrashView.id);
                  },
                  action: 'موافق',
                );
              },
            );
          } else {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                Navigator.pushNamed(context, RegisterView.id);

                log('User is currently signed out!');
              } else {
                if (user.emailVerified) {
                  Navigator.pushNamed(context, BottomNavigator.id);

                  log('User is signed in!');
                } else if (!user.emailVerified) {
                  Navigator.pushNamed(context, LoginView.id);
                } else {
                  Navigator.pushNamed(context, RegisterView.id);
                }
              }
            });
          }

          // FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //   if (user == null) {
          //      GoRouter.of(context).push('/${RegisterPage.id}');
          //     log('User is currently signed out!');
          //   } else {
          //     if (user.emailVerified) {
          //       GoRouter.of(context).push('/${MyHome.id}');
          //       log('User is signed in!');
          //     } else if (!user.emailVerified) {
          //      GoRouter.of(context).push('/${VerificationView.id}');
          //     } else {
          //       GoRouter.of(context).push('/${LoginPage.id}');
          //     }
          //   }
          // });

          //  else {
          //   bool isLoggedIn =
          //       await SharedPreference().getBool("isLoggedIn") ?? false;
          //   if (isLoggedIn &&relogin==false ) {

          //     GoRouter.of(context).push('/${MyHome.id}');
          //   } else {

          //     GoRouter.of(context).push('/${LoginPage.id}');
          //   }
          // }
        },
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
              Assets.imagesSplashScreen,
            )))
          ],
        ),
      ),
    );
  }
}
