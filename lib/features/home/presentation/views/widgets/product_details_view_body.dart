import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/image_product_details.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/product_details.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody(
      {super.key, required this.productModel, });

  final ProductModel productModel;
  //final S s;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          IconButton(
              onPressed: () {
      Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          ImageProductDetails(productModel: productModel),
          const Divider(thickness: .5,),
          ProductDetails(productModel: productModel, ),
        ],
      ),
    );
  }
}
