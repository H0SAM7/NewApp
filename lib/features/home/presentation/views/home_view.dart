import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/core/widgets/custom_loading_indecator.dart';
import 'package:my_visitor/features/home/presentation/manager/all_products_cubit/all_products_cubit.dart';
import 'package:my_visitor/features/home/presentation/views/category_products_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_adv_widget.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/products_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemSpacing = size.width * 0.002; // Responsive item spacing
    double childAspectRatio = (size.width / 2) / (size.height * .53);
    return BlocBuilder<AllProductsCubit, AllProductsState>(
      builder: (context, state) {
        if (state is AllProductsSuccess) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            slivers: [
              //SliverToBoxAdapter(child: CustomAppBar()),
              SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(child: CategoryCircle()),
              SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(child: CustomAdvWidget(size: size)),
              SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Clothing',
                  style: AppStyles.style32(context, Colors.black),
                ),
              )),
              ProductsListViewForHome(categoryName: 'Clothing'),
              SliverToBoxAdapter(child: Divider()),

              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Toys',
                  style: AppStyles.style32(context, Colors.black),
                ),
              )),
              SliverToBoxAdapter(child: Divider()),

              ProductsListViewForHome(categoryName: 'Toys'),

              SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Shoes',
                  style: AppStyles.style32(context, Colors.black),
                ),
              )),
              ProductsListViewForHome(categoryName: 'Shoes'),
              SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'General',
                  style: AppStyles.style32(context, Colors.black),
                ),
              )),
              ProductsListView(
                  // size: size,
                  // childAspectRatio: childAspectRatio,
                  // itemSpacing: itemSpacing,
                  products: state.products),
            ],
          );
        } else if (state is AllProductsFailure) {
          return Center(child: Text('S.of(context).Error_loading_products'));
        } else {
          return const Center(child: CustomLoadingIndicator());
        }
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                Assets.iconsMenu,
                color: orangeColor,
              ),
            ),
            Center(
              child: Image.asset(Assets.imagesLogo),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: orangeColor,
                )),
          ],
        ),
      ),
    );
  }
}

class CategoryCircle extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "Clothing", "image": Assets.imagesClothing},
    {"title": "electronics", "image": Assets.imagesElectronics},
    {"title": "Toys", "image": Assets.imagesToys},
    {"title": "Accessories", "image": Assets.imagesAccessories},
    {"title": "jewelery", "image": Assets.imagesJewelery},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CategoryProductsView.id,
                  arguments: categories[index]["title"]!);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      categories[index]["image"]!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    categories[index]["title"]!,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
