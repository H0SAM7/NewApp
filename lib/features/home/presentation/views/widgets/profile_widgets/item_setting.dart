import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  final String title;
  final IconData prefixIcon;
  final VoidCallback onTap;
  final Widget suffixIcon;


  const ItemSetting({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.onTap,
    required this.suffixIcon,

  });

  @override
  Widget build(BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              prefixIcon,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
            const Spacer(),
            suffixIcon,
          ],
        ),
      ),
    );
  }
}
