import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_product_item.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLandscape = screenSize.width > screenSize.height;
    
    // Dynamically adjust grid properties
    int crossAxisCount = isLandscape ? 3 : (screenSize.width > 600 ? 3 : 2);
    double childAspectRatio = screenSize.width > 600 ? 0.75 : 0.81;
    double itemSpacing = screenSize.width > 600 ? 10.0 : 5.0;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: itemSpacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: itemSpacing,
          crossAxisSpacing: itemSpacing,
          childAspectRatio: childAspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CustomProductItem(productModel: products[index]);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
