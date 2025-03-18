import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/profile_widgets/item_setting.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    //final s = S.of(context);
    return Column(
      children: [
        ItemSetting(
          title: 's.update_account',
          prefixIcon: Icons.account_box,
          onTap: () {
            //  Navigator.pushNamed(context, UpdateProfilePage.id);
       //     GoRouter.of(context).push('/${UpdateProfilePage.id}');
          },
          suffixIcon: Container(),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: .3,
        ),
        //  const SizedBox(height: 10),
        ItemSetting(
            title: 's.delete_my_account',
            prefixIcon: Icons.delete,
            onTap: () {
            //  deketeAccountConfirmationDialog(context);
              //  log('deleted done');
            },
            suffixIcon: Container()),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: .3,
        ),
        // const SizedBox(height: 15),
        ItemSetting(
            title: 's.log_out',
            prefixIcon: Icons.logout,
            onTap: () async {
             // await BlocProvider.of<AuthCubit>(context).logout();
              log('logout done');
    
           //  GoRouter.of(context).clearStackAndNavigate('/${LoginPage.id}');
            },
            suffixIcon: Container()),
      ],
    );
  }
}
