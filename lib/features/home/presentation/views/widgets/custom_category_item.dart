import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/features/home/presentation/views/category_products_view.dart';

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    //  final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //   GoRouter.of(context).push('/${CategoryProductsView.id }', extra:name);
        Navigator.pushNamed(context, CategoryProductsView.id, arguments: name);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
              color: orangeColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/$name.jpg"),
                  fit: BoxFit.fill)),
                 
        ),
      ),
    );
  }
}
