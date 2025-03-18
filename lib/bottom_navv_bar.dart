import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/features/cart/presentation/views/cart_view.dart';
import 'package:my_visitor/features/home/presentation/views/categories_view.dart';
import 'package:my_visitor/features/home/presentation/views/home_view.dart';
import 'package:my_visitor/features/home/presentation/views/settings_view.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  static String id = 'BottomNavigator';

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeView(),
    CategoriesView(),
    CartView(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.iconsMenu,
            color: orangeColor,
          ),
        ),
        title: Center(
          child: Image.asset(Assets.imagesLogo),
        ),
        actions: [
          IconButton(
              onPressed: () {
             //   Navigator.pushNamed(context, SettingsScreen.id);
              },
              icon: Icon(
                Icons.person,
                color: orangeColor,
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsHome,
              color: orangeColor,
              height: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
              color: orangeColor,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: orangeColor,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: orangeColor,
            ),
            label: 'Settings',
          ),
        ],
        selectedItemColor: orangeColor,
        selectedLabelStyle: TextStyle(color: orangeColor),
        selectedFontSize: 10,
        showUnselectedLabels: false,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
