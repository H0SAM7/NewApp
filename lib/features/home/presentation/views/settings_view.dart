import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/core/utils/shared_pref.dart';
import 'package:my_visitor/features/Notifications/services/send_notifications_view.dart';
import 'package:my_visitor/features/Notifications/views/notifi_view.dart';
import 'package:my_visitor/features/admins/presentation/views/add_products_view.dart';
import 'package:my_visitor/features/admins/presentation/views/delete_view.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/cart/views/cart_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/setting_container.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  static String id = 'SettingsScreen';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? admin;

  @override
  void initState() {
    super.initState();
    _loadAdminStatus();
  }

  Future<void> _loadAdminStatus() async {
    bool? isAdmin = await SharedPreference().getBool('admin');
    setState(() {
      admin = isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              admin == true
                  ? const SettingContainer(
                      child: AdminSettings(),
                    )
                  : SizedBox(),
              const SettingContainer(
                child: SettingsView(),
              ),
              SettingContainer(
                child: ItemSetting(
                  leading: Image.asset(Assets.iconsLogoutIcon),
                  title: 'Log out',
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSetting(
          leading: Icon(
            Icons.add,
            color: orangeColor,
          ),
          title: 'Add Product',
          onTap: () {
            Navigator.pushNamed(context, AddProductsView.id);
          },
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsCartIcon),
          title: 'Cart',
          onTap: () async {
            await BlocProvider.of<CartCubit>(context).fetchAllItems();

            Navigator.pushNamed(context, CartView.id);
          },
        ),
        ItemSetting(
          onTap: () {
            Navigator.pushNamed(context, NotifiView.id);
          },
          leading: Image.asset(Assets.iconsNotifiIcon),
          title: 'Notifications',
        ),
      ],
    );
  }
}


class AdminSettings extends StatelessWidget {
  const AdminSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemSetting(
          leading: Icon(
            Icons.remove,
            color: orangeColor,
          ),
          title: 'Delete Product',
          onTap: () {
           Navigator.pushNamed(context, DeleteProductsView.id);
          },
        ),
        ItemSetting(
          leading: Image.asset(Assets.iconsCartIcon),
          title: 'Send Notifications',
          onTap: () async {
             Navigator.pushNamed(context, SendNotifactionsSendView.id);
          },
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
