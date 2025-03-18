import 'package:flutter/material.dart';

import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/product_details_view_body.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.productModel});
  static const String id = 'DetailsPage';
  final ProductModel productModel;
  @override
    Widget build(BuildContext context) {
    // bool isarabic = isArabic(context);
  //  final s = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ProductDetailsBody(productModel: productModel, ),
    );
  }
}
