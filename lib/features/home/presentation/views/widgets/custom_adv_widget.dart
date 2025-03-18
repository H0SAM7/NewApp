import 'package:flutter/material.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/adv_animation_bar.dart';

class CustomAdvWidget extends StatelessWidget {
  const CustomAdvWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .188,
      width: size.width,
      child: AdvarticementsAnimationBar(
        color: const Color(0xFFCAF0F8),
        image: Assets.imagesAdv,
        text: '',
      ),
    );
  }
}
