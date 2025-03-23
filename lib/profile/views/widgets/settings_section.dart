import 'package:my_visitor/core/utils/assets.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSetting(
          leading: Image.asset(Assets.iconsFaqsIcon),
          title: 'FAQs',
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsReviewsIcon),
          title: 'User Reviews',
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsSettingsIcon),
          title: 'Settings',
        ),
      ],
    );
  }
}

class ItemSetting extends StatelessWidget {
  const ItemSetting({super.key, required this.title, this.leading, this.onTap});
  final String title;
  final Widget? leading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: Image.asset(Assets.iconsChevronRight),
      ),
    );
  }
}
