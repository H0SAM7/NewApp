// import 'package:my_visitor/bottom_navigator_bar.dart';
// import 'package:my_visitor/core/utils/assets.dart';
// import 'package:flutter/material.dart';

// class SocialAuth extends StatelessWidget {
//   const SocialAuth({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SocialIcon(
//           icon: Icons.facebook,
//           color: Color(0xFF3b5998),
//           onPressed: () {
//             Navigator.pushNamed(context, BottomNavigator.id);
//           },
//         ),
//         const SizedBox(width: 20),
//         GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, BottomNavigator.id);
//           },
//          // child: 
//           // CircleAvatar(
//           //   radius: 30,
//           //   backgroundColor: Colors.white,
//           //   child: Image.asset(Assets.iconsGoogle),
//           // ),
//         ),
//       ],
//     );
//   }
// }

// class SocialIcon extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final VoidCallback onPressed;

//   const SocialIcon(
//       {super.key,
//       required this.icon,
//       required this.color,
//       required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: CircleAvatar(
//         radius: 25,
//         backgroundColor: color,
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//     );
//   }
// }
