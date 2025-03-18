
import 'package:flutter/material.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/adv_animation_bar.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/adv_item.dart';

class AdvarticementsBody extends StatelessWidget {
  const AdvarticementsBody({
    super.key,
    required PageController pageController,
    required this.widget,
  }) : _pageController = pageController;

  final PageController _pageController;
  final AdvarticementsAnimationBar widget;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
     
     
           Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              //color: widget.color,
              borderRadius: BorderRadius.circular(5),
              image:  DecorationImage(image: AssetImage(Assets.imagesAdv),
              fit: BoxFit.fill,
              )
            ),
          ),
        ),
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              //color: widget.color,
              borderRadius: BorderRadius.circular(5),
              image:  DecorationImage(image: AssetImage(Assets.imagesAdv2),
              fit: BoxFit.fill,
              )
            ),
          ),
        ),
              Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              //color: widget.color,
              borderRadius: BorderRadius.circular(5),
              image:  DecorationImage(image: AssetImage(Assets.imagesAdv2),
              fit: BoxFit.fill,
              )
            ),
          ),
        ),
              
      ],
    );
  }
}