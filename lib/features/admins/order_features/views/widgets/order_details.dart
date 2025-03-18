
import 'package:flutter/material.dart';

import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/categories_list_view.dart';

class OrderDetails extends StatelessWidget {
  static String id='OrderDetails';
  const OrderDetails({super.key, required this.products});
final  List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Expanded(
            child: CategoriesListView(
              products: products,
            ),
          )
        ],
      ),
    );
  }
}
