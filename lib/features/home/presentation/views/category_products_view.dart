import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_visitor/core/widgets/custom_loading_indecator.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/categories_list_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_product_item.dart';
import 'package:my_visitor/services/fire_base_services.dart';


class CategoryProductsView extends StatelessWidget {
  static String id='categoryPage';
  const CategoryProductsView({super.key, });
  @override
  Widget build(BuildContext context) {

        String categoryName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
      body: Padding(
         padding: const EdgeInsets.only(left: 6, right: 6, top: 20,),
        child: FutureBuilder<List<ProductModel>>(
          future:FireBaseServices().getCategoryProducts(categoryName, ),
          builder: (context, snapshot) {
            log(categoryName);
            if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;
              return CategoriesListView(products: products);
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}



class ProductsListViewForHome extends StatelessWidget {
  const ProductsListViewForHome({
    super.key,
  required this.categoryName,
  });

final String categoryName;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    
    double itemWidth = isTablet ? screenSize.width * 0.3 : screenSize.width * 0.5;
    double itemHeight = isTablet ? 280 : 250;
    double spacing = isTablet ? 15.0 : 10.0;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SizedBox(
          height: itemHeight, // Adjust height based on screen
          child: FutureBuilder<List<ProductModel>>(
            future: FireBaseServices().getCategoryProducts(categoryName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Loading state
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}")); // Error state
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No products found")); // No data state
              }
        
              // Data is available, display the list
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spacing),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: itemWidth, // Responsive item width
                    margin: EdgeInsets.only(right: spacing), // Adjust spacing dynamically
                    child: CustomProductItem(productModel: snapshot.data![index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
