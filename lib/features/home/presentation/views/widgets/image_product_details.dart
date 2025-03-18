import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';

class ImageProductDetails extends StatelessWidget {
  const ImageProductDetails({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: productModel.image,
      fit: BoxFit.contain,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
