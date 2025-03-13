import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class screenTSt extends StatelessWidget {
  const screenTSt({super.key});
static String id='screenTSt';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Success'))
        ],
      ),
    );
  }
}