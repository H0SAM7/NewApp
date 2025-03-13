// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_visitor/constants.dart';
// import 'package:my_visitor/core/utils/assets.dart';
// import 'package:my_visitor/features/ML/presentation/views/scan_view.dart';
// import 'package:my_visitor/features/home/presentation/views/home_view.dart';

// class BottomNavigator extends StatefulWidget {
//   const BottomNavigator({super.key});
//   static String id = 'BottomNavigator';

//   @override
//   State<BottomNavigator> createState() => _BottomNavigatorState();
// }

// class _BottomNavigatorState extends State<BottomNavigator> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     HomeView(),
//     ScanView(),

//     HomeView(),
//     HomeView(),

 
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               Assets.iconsHome,
//               color: orangeColor,
//               //height: 20,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               Assets.imagesScan2,
//               color: orangeColor,
//              height: 30,
//             ),
//             label: 'Scan',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,

//             icon: Icon(
//               Icons.settings,
//               color: orangeColor,
//               size: 25,
//             ),
//             //   Image.asset(
//             //     Assets.iconsSettingsIcon,
//             //  //  color: orangeColor,
//             //     height: 20,
//             //   ),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.scanner),

//             ///Image.asset(Assets.iconsPlusIcon),
//             label: '',
//           ),
//         ],
//         selectedItemColor: Colors.orange,
//         selectedLabelStyle: TextStyle(
//           color: Colors.orange,
//         ),
//         selectedFontSize: 10,
//         showUnselectedLabels: false,
//       ),
//     );
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
