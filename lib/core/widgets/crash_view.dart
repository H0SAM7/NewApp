
import 'package:flutter/material.dart';

class CrashView extends StatelessWidget {
  const CrashView({super.key});
  static String id='CrashView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('The Service is not avalible now '),
          )
        ],
      ),
    );
  }
}