import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/core/utils/functions/custom_methods.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/profile_widgets/item_setting.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettings();
}

class _SystemSettings extends State<SystemSettings> {
  @override
  Widget build(BuildContext context) {
   // final s = S.of(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        ItemSetting(
          title: 's.language',
          prefixIcon: Icons.language,
          onTap: () {
            // log(isArabic(context).toString());
            // context.read<LanguageCubit>().setLocale(
            //       isArabic(context)
            //           ? const Locale('en', '')
            //           : const Locale('ar', ''),
            //     );
          },
          suffixIcon: Row(
            children: [
              Text(
                isArabic(context)
                    ? 'English'
                    : 'العربية', // Change text based on current locale
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5)),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                size: 19,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ItemSetting(
          title:' s.dark_mode',
          prefixIcon: Icons.mode_night_outlined,
          onTap: () {},
          suffixIcon: Switch(
              value: isDarkMode,
              onChanged: (val) {
                setState(() {
                  isDarkMode = val;
                });
             //   context.read<ThemeCubit>().toggleTheme();
                // FunnyBaby.of(context).changeTheme(
                //     !widget.isDark ? ThemeMode.light : ThemeMode.dark);
              }),
        ),
      ],
    );
  }
}
