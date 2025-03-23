import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/home/presentation/views/product_details_view.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_image_procduct.dart';

class CategoryListViewProductItem extends StatelessWidget {
  const CategoryListViewProductItem({
    super.key,
    required this.productModel,
    this.details = true,
  });

  final bool details;
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailsPage.id ,arguments: productModel);
      },
      child: Container(
          decoration: BoxDecoration(
            color: !isDarkMode ? Colors.white : Colors.transparent,
          ),
          child: ListTile(
            leading: SizedBox(
              height: 120,
              child: CustomImage(image: productModel.image),
            ),
            title: Text(
              _truncateText(productModel.title, 4),
              style: TextStyle(
                color: !isDarkMode ? redColor : Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.amiri().fontFamily,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            
            subtitle: Text(
              "\$ ${"Free"}",
              style: TextStyle(
                color: !isDarkMode ? redColor : Colors.white,
                fontSize: 18,
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                await BlocProvider.of<CartCubit>(context).addItem(productModel);
            //   showSnackbar(context, 'تم اضافة المنتج الي السلة');
              },
              icon: Icon(
                FontAwesomeIcons.cartShopping,
                color: !isDarkMode ? redColor : Colors.white,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          )),
    );
  }

  String _truncateText(String text, int maxWords) {
    final words = text.split(' ');
    if (words.length <= maxWords) {
      return text;
    } else {
      return '${words.take(maxWords).join(' ')}...';
    }
  }
}
