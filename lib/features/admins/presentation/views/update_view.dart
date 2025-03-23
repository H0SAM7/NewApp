import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/widgets/custom_button.dart';
import 'package:my_visitor/features/admins/presentation/views/add_products_view.dart';
import 'package:my_visitor/features/admins/presentation/views/widgets/custom_dropdown.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/admins/presentation/manager/admin_cubit/admin_cubit.dart';

class UpdateProductsView extends StatefulWidget {
  const UpdateProductsView({super.key});
  static String id = 'UpdateProductsView';

  @override
  State<UpdateProductsView> createState() => _UpdateProductsViewState();
}

class _UpdateProductsViewState extends State<UpdateProductsView> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  String? image;
  bool loaded = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String? uploadedImage = await BlocProvider.of<AdminCubit>(context)
          .uploadImage(image: pickedFile);
      setState(() {
        _image = File(pickedFile.path);
        image = uploadedImage;
        loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminSuccess) {
            clearFieldsMethod();
          } else if (state is AdminFailure) {
            // Handle failure case
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFrom(
                  label: 'Product ID',
                  hint: 'Enter Product ID',
                  controller: idController,
                  readOnly: true,
                ),
                CustomTextFrom(
                  label: 'Product Title',
                  hint: 'Enter product title',
                  controller: titleController,
                ),
                CustomTextFrom(
                  label: 'Product Price',
                  hint: 'Enter product price',
                  controller: priceController,
                ),
                CustomTextFrom(
                  label: 'Product Description',
                  hint: 'Enter product description',
                  controller: descriptionController,
                ),
                CustomDropDown(
                  menuList: categories,
                  onChanged: (selectedValue) {
                    categoryController.text = selectedValue!;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromARGB(255, 110, 161, 228),
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.upload, size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: const Text("Upload Image"),
                ),
                const SizedBox(height: 25),
                loaded
                    ? CustomButton(
                        title: 'Update',
                        color: redColor,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<AdminCubit>(context)
                                .updateProduct(
                              productModel: ProductModel(
                                code: idController.text,
                                title: titleController.text.isNotEmpty
                                    ? titleController.text
                                    : '',
                                description:
                                    descriptionController.text.isNotEmpty
                                        ? descriptionController.text
                                        : '',
                                category: categoryController.text.isNotEmpty
                                    ? categoryController.text
                                    : '',
                                image: image ?? '',
                              ),
                            );
                            log('Update data Done');
                            loaded = false;
                            setState(() {});
                          }
                        },
                      )
                    : const Text('Please Upload an image if needed'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearFieldsMethod() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    categoryController.clear();
  }
}
