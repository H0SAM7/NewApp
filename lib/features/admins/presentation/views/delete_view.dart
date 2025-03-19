import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/widgets/custom_button.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/admins/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';

class DeleteProductsView extends StatefulWidget {
  const DeleteProductsView({super.key});
  static String id = 'DeleteProductsView';

  @override
  State<DeleteProductsView> createState() => _DeleteProductsViewState();
}

class _DeleteProductsViewState extends State<DeleteProductsView> {
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Product',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminSuccess) {
            clearFieldsMethod();
          } else if (state is AdminFailure) {
            // Handle failure
          }
        },
        child: SingleChildScrollView(
          child: Form(
            child: SafeArea(
              child: Column(
                children: [
                  CustomTextFrom(
                    label: 'Product Code',
                    hint: 'Enter Product Code to Delete',
                    controller: codeController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Delete',
                    color: Colors.red,
                    onTap: () async {
                      if (codeController.text.isNotEmpty) {
                        await BlocProvider.of<AdminCubit>(context).deleteProduct(
                          parcode: codeController.text,
                        );
                        log('Product Deleted');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearFieldsMethod() {
    codeController.clear();
  }
}
