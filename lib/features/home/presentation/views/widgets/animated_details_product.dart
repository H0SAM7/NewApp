
// import 'package:flutter/material.dart';
// import 'package:funny_baby/core/models/product_model.dart';
// import 'package:funny_baby/generated/l10n.dart';
// import 'package:funny_baby/features/home/presentation/views/widgets/product_details.dart';

// class AnimatedDetailsProduct extends StatelessWidget {
//   const AnimatedDetailsProduct({
//     super.key,
//     required this.size,
//     required bool isVisible,
//     required this.productModel,
//     required this.s,
//   }) : _isVisible = isVisible;

//   final Size size;
//   final bool _isVisible;
//   final ProductModel productModel;
//   final S s;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: size.height * .56,
//           left: size.width * .1,
//           right: size.width * .1,
//         ),
//         child: Column(
//           children: [
//             AnimatedOpacity(
//               opacity: _isVisible ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 500),
//               child: ProductDetails(
//                   size: size,
//                   productModel: productModel,
//                   s: s,
//                   isVisible: _isVisible),
//             ),
//             if (!_isVisible)
//               Text(
//                 s.click_to_view_details,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
