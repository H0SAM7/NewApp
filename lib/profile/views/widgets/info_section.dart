import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/features/home/presentation/views/settings_view.dart';

import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSetting(
          leading: Image.asset(Assets.iconsUser),
          title: 'Personal Info',
          onTap: () {
          //  Navigator.pushNamed(context, PersonalInfoView.id);
          },
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsHomeAddressIcon),
          title: 'Address',
          onTap: () {
        //    Navigator.pushNamed(context, AddressView.id);
          },
        ),
      ],
    );
  }
}
