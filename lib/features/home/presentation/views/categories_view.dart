import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/presentation/views/add_products_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_category_item.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  static const id = 'CategoriesPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double childAspectRatio =
        (size.width / 2) / (size.height * .2); // Adjust aspect ratio
    //final s = S.of(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > size.height ? 3 : 2,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CustomCategoryItem(
            name: categories[index],
          );
        },
      ),
    ));
  }
}
