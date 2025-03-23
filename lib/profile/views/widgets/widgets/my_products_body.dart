import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/cart/views/widgets/cart_list_view.dart';

class MyProductsBody extends StatelessWidget {
  const MyProductsBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: .2,
            color: redColor,
          ),
        ),
        child: Column(
          children: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is FeachAllItemsSuccess) {
                  return Expanded(
                    child: CartListView(
                      products:
                          BlocProvider.of<CartCubit>(context).myProducts,
                    ),
                  );
                } else {
                  return const Center(child: Text('You are not add any products yet.'));
                }
              },
            ),
            BlocProvider.of<CartCubit>(context).myProducts.isEmpty
                ? const Center(child: Text('No Items'))
                : Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // GoRouter.of(context).push('/${PaymentOptionView.id}',
                        //     extra: BlocProvider.of<CartCubit>(context)
                        //         .items);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.productHunt,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
