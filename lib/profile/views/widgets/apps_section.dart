import 'package:my_visitor/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/cart/views/cart_view.dart';
import 'package:my_visitor/features/home/presentation/views/settings_view.dart';

class AppSections extends StatelessWidget {
  const AppSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSetting(
          leading: Image.asset(Assets.iconsCartIcon),
          title: 'Cart',
          onTap: () async{
            await BlocProvider.of<CartCubit>(context).fetchAllItems();
         
            Navigator.pushNamed(context, CartView.id);
          },
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsFavoIcon),
          title: 'Favourits',
        ),
        ItemSetting(
          onTap: (){
                 //       Navigator.pushNamed(context, NotifiView.id);

          },
          leading: Image.asset(Assets.iconsNotifiIcon),
          title: 'Notifications',
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsPaymentIcon),
          title: 'Payment',
          onTap: () {
          //  Navigator.pushNamed(context, PymentView.id);
          },
        ),
      ],
    );
  }
}
