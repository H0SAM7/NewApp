import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_visitor/features/home/presentation/views/widgets/adv_animation_bar_body.dart';




class AdvarticementsAnimationBar extends StatefulWidget {
 const AdvarticementsAnimationBar({super.key, this.color, this.image, this.text});
  static String id = 'TestPage';
 final String? image, text;
final  Color? color;
  @override
  State<AdvarticementsAnimationBar> createState() => _AdvarticementsAnimationBarState();
}

class _AdvarticementsAnimationBarState extends State<AdvarticementsAnimationBar> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AdvarticementsBody(pageController: _pageController, widget: widget),
    );
  }
}

