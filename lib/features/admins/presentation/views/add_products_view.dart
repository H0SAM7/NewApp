import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/widgets/custom_button.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/admins/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:my_visitor/features/admins/presentation/views/widgets/custom_dropdown.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';

class AddProductsView extends StatefulWidget {
  const AddProductsView({super.key});
  static String id = 'AddProductsPage';

  @override
  State<AddProductsView> createState() => _AddProductsViewState();
}

class _AddProductsViewState extends State<AddProductsView> {
  final TextEditingController codeController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  String? image, category;

  bool loaded = false;
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

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
  void dispose() {
    codeController.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  String? imageUrl;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    //  final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminSuccess) {
            //     showSnackbar(context, s.add_new_product_done);
            clearFieldsMethod();
          } else if (state is AdminFailure) {
            //    showSnackbar(context, s.please_fill_all_fields);
          }
        },
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: redColor,
          onRefresh: () async {
            // Replace this delay with the code to be executed during refresh
            // and return asynchronous code
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: SafeArea(
                child: Column(
                  children: [
                    CustomTextFrom(
                      label: 'Product Code',
                      hint: ' Enter Product Code',
                      controller: codeController,
                    ),
                    CustomTextFrom(
                      label: 'Product Name',
                      hint: ' Enter Product Name',
                      controller: titleController,
                    ),
                    CustomTextFrom(
                      label: 'Product Description',
                      hint: 'Enter Product Description',
                      controller: descriptionController,
                    ),
                    // CustomTextFrom(
                    //   label: ' Product Price',
                    //   hint: 'Enter Product Price',
                    //   controller: priceController,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDropDown(
                          menuList: categories,
                          onChanged: (selectedValue) {
                            categoryController.text = selectedValue!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 110, 161, 228),
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? Icon(Icons.upload,
                                    size: 40,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255))
                                : null,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.image),
                          label: Text("Upload Image"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // IconButton(
                    //   onPressed: () async {
                    //     for (var pp in productList) {
                    //         await BlocProvider.of<AdminCubit>(context)
                    //                 .addProduct(productModel: pp);

                    //     }
                    //     log('doonnne');
                    //   },
                    //   icon: Icon(
                    //     Icons.import_contacts,
                    //     size: 50,
                    //   ),
                    // ),
                    loaded
                        ? CustomButton(
                            title: 'Send',
                            color: redColor,
                            onTap: () async {
                              if (fromKey.currentState!.validate()) {
                                await BlocProvider.of<AdminCubit>(context)
                                    .addProduct(
                                  productModel: ProductModel(
                                    code: codeController.text,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    category: categoryController.text,
                                    image: image!,
                                  ),
                                );
                                log('send data Done');
                                loaded = false;
                                setState(() {});
                                await BlocProvider.of<CartCubit>(context)
                                    .addItem(
                                  ProductModel(
                                    code: codeController.text,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    category: categoryController.text,
                                    image: image!,
                                  ),
                                );
                                await BlocProvider.of<CartCubit>(context)
                                    .fetchMyProducts();
                              }
                            },
                          )
                        : Text('Please Upload the image'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearFieldsMethod() {
    codeController.clear();
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    categoryController.clear();
  }

  // Future<void> addProductMethod() async {
  //   await FireBaseServices().addProduct(ProductModel(
  //     code: codeController.text,
  //     parcode: codeController.text,
  //     title: titleController.text,
  //     price: priceController.text,
  //     description: descriptionController.text,
  //     category: categoryController.text,
  //     image: image!,
  //     size: sizeController.text,
  //     count: int.tryParse(countController.text) ?? 0,
  //     gender: genderController.text,
  //     cart: false,
  //     discount: double.tryParse(discountController.text) ?? 0,
  //   ));
  // }
}

final List<String> categories = [
  "Clothing",
  "Shoes",
  "Books",
  "jewelery",
  "electronics",
  "Furniture",
  "Accessories",
  "Toys",
  "MedicalSupplies",
  "Other"
];

List<ProductModel> productList = [
  ProductModel(
    code: "8",
    title: "Classic Red Jogger Sweatpants",
    description:
        "Experience ultimate comfort with our red jogger sweatpants...",
    category: "Clothing",
    image: "https://i.imgur.com/9LFjwpI.jpeg",
  ),
  ProductModel(
    code: "12",
    title: "Classic Black Baseball Cap",
    description:
        "Elevate your casual wear with this timeless black baseball cap...",
    category: "Clothing",
    image: "https://i.imgur.com/KeqG6r4.jpeg",
  ),
  ProductModel(
    code: "13",
    title: "Classic Olive Chino Shorts",
    description:
        "Elevate your casual wardrobe with these classic olive chino shorts...",
    category: "Clothing",
    image: "https://i.imgur.com/UsFIvYs.jpeg",
  ),
  ProductModel(
    code: "14",
    title: "Classic High-Waisted Athletic Shorts",
    description:
        "Stay comfortable and stylish with our Classic High-Waisted Athletic Shorts...",
    category: "Clothing",
    image: "https://i.imgur.com/eGOUveI.jpeg",
  ),
  ProductModel(
    code: "18",
    title: "Sleek White & Orange Wireless Gaming Controller",
    description:
        "Elevate your gaming experience with this state-of-the-art wireless controller...",
    category: "Electronics",
    image: "https://i.imgur.com/ZANVnHE.jpeg",
  ),
  ProductModel(
    code: "19",
    title: "Sleek Wireless Headphone & Inked Earbud Set",
    description:
        "Experience the fusion of style and sound with this sophisticated audio set...",
    category: "Electronics",
    image: "https://i.imgur.com/yVeIeDa.jpeg",
  ),
  ProductModel(
    code: "21",
    title: "Efficient 2-Slice Toaster",
    description:
        "Enhance your morning routine with our sleek 2-slice toaster...",
    category: "Electronics",
    image: "https://i.imgur.com/keVCVIa.jpeg",
  ),
  ProductModel(
    code: "22",
    title: "Sleek Wireless Computer Mouse",
    description:
        "Experience smooth and precise navigation with this modern wireless mouse...",
    category: "Electronics",
    image: "https://i.imgur.com/w3Y8NwQ.jpeg",
  ),
  ProductModel(
    code: "23",
    title: "Sample Product",
    description: "Test",
    category: "Electronics",
    image: "https://i.imgur.com/ItHcq7o.jpeg",
  ),
  ProductModel(
    code: "24",
    title: "Sleek Modern Laptop for Professionals",
    description:
        "Experience cutting-edge technology and elegant design with our latest laptop...",
    category: "Electronics",
    image: "https://i.imgur.com/ItHcq7o.jpeg",
  ),
  ProductModel(
    code: "25",
    title: "Stylish Red & Silver Over-Ear Headphones",
    description:
        "Immerse yourself in superior sound quality with these sleek red and silver headphones...",
    category: "Electronics",
    image: "https://i.imgur.com/YaSqa06.jpeg",
  ),
  ProductModel(
    code: "26",
    title: "Sleek Mirror Finish Phone Case",
    description:
        "Enhance your smartphone's look with this ultra-sleek mirror finish phone case...",
    category: "Accessories",
    image: "https://i.imgur.com/yb9UQKL.jpeg",
  ),
  ProductModel(
    code: "27",
    title: "Sleek Smartwatch with Vibrant Display",
    description:
        "Experience modern timekeeping with our high-tech smartwatch...",
    category: "Electronics",
    image: "https://i.imgur.com/LGk9Jn2.jpeg",
  ),
  ProductModel(
    code: "28",
    title: "Sleek Modern Leather Sofa",
    description:
        "Enhance the elegance of your living space with our Sleek Modern Leather Sofa...",
    category: "Furniture",
    image: "https://i.imgur.com/Qphac99.jpeg",
  ),
  ProductModel(
    code: "29",
    title: "Mid-Century Modern Wooden Dining Table",
    description:
        "Elevate your dining room with this sleek Mid-Century Modern dining table...",
    category: "Furniture",
    image: "https://i.imgur.com/DMQHGA0.jpeg",
  ),
  ProductModel(
    code: "30",
    title: "Elegant Golden-Base Stone Top Dining Table",
    description: "Elevate your dining space with this luxurious table...",
    category: "Furniture",
    image: "https://i.imgur.com/NWIJKUj.jpeg",
  ),
  ProductModel(
    code: "31",
    title: "Modern Elegance Teal Armchair",
    description:
        "Elevate your living space with this beautifully crafted armchair...",
    category: "Furniture",
    image: "https://i.imgur.com/6wkyyIN.jpeg",
  ),
  ProductModel(
    code: "32",
    title: "Elegant Solid Wood Dining Table",
    description:
        "Enhance your dining space with this sleek, contemporary dining table...",
    category: "Furniture",
    image: "https://i.imgur.com/4lTaHfF.jpeg",
  ),
  ProductModel(
    code: "33",
    title: "Modern Minimalist Workstation Setup",
    description:
        "Elevate your home office with our Modern Minimalist Workstation Setup...",
    category: "Furniture",
    image: "https://i.imgur.com/3oXNBst.jpeg",
  ),
  ProductModel(
    code: "34",
    title: "Modern Ergonomic Office Chair",
    description:
        "Elevate your office space with this sleek and comfortable Modern Ergonomic Office Chair...",
    category: "Furniture",
    image: "https://i.imgur.com/3dU0m72.jpeg",
  ),
  ProductModel(
    code: "35",
    title: "Futuristic Holographic Soccer Cleats",
    description:
        "Step onto the field and stand out from the crowd with these eye-catching holographic soccer cleats...",
    category: "Shoes",
    image: "https://i.imgur.com/qNOjJje.jpeg",
  ),
  ProductModel(
    code: "36",
    title: "Rainbow Glitter High Heels",
    description:
        "Step into the spotlight with these eye-catching rainbow glitter high heels...",
    category: "Shoes",
    image: "https://i.imgur.com/62gGzeF.jpeg",
  ),
  ProductModel(
    code: "37",
    title: "Chic Summer Denim Espadrille Sandals",
    description:
        "Step into summer with style in our denim espadrille sandals...",
    category: "Shoes",
    image: "https://i.imgur.com/9qrmE1b.jpeg",
  ),
  ProductModel(
    code: "38",
    title: "Vibrant Runners: Bold Orange & Blue Sneakers",
    description:
        "Step into style with these eye-catching sneakers featuring a striking combination...",
    category: "Shoes",
    image: "https://i.imgur.com/hKcMNJs.jpeg",
  ),
  ProductModel(
    code: "39",
    title: "Vibrant Pink Classic Sneakers",
    description: "Step into style with our Vibrant Pink Classic Sneakers!...",
    category: "Shoes",
    image: "https://i.imgur.com/mcW42Gi.jpeg",
  ),
  ProductModel(
    code: "40",
    title: "Futuristic Silver and Gold High-Top Sneaker",
    description:
        "Step into the future with this eye-catching high-top sneaker...",
    category: "Shoes",
    image: "https://i.imgur.com/npLfCGq.jpeg",
  ),
  ProductModel(
    code: "41",
    title: "Futuristic Chic High-Heel Boots",
    description: "Elevate your style with our cutting-edge high-heel boots...",
    category: "Shoes",
    image: "https://i.imgur.com/HqYqLnW.jpeg",
  ),
  ProductModel(
    code: "42",
    title: "Elegant Patent Leather Peep-Toe Pumps with Gold-Tone Heel",
    description: "Step into sophistication with these chic peep-toe pumps...",
    category: "Shoes",
    image: "https://i.imgur.com/AzAY4Ed.jpeg",
  ),
  ProductModel(
    code: "43",
    title: "Elegant Purple Leather Loafers",
    description:
        "Step into sophistication with our Elegant Purple Leather Loafers...",
    category: "Shoes",
    image: "https://i.imgur.com/Au8J9sX.jpeg",
  ),
  ProductModel(
    code: "44",
    title: "Classic Blue Suede Casual Shoes",
    description:
        "Step into comfort with our Classic Blue Suede Casual Shoes...",
    category: "Shoes",
    image: "https://i.imgur.com/sC0ztOB.jpeg",
  ),
  ProductModel(
    code: "45",
    title: "Sleek Futuristic Electric Bicycle",
    description:
        "This modern electric bicycle combines style and efficiency...",
    category: "Other",
    image: "https://i.imgur.com/BG8J0Fj.jpg",
  ),
  ProductModel(
    code: "46",
    title: "Sleek All-Terrain Go-Kart",
    description:
        "Experience the thrill of outdoor adventures with our Sleek All-Terrain Go-Kart...",
    category: "Toys",
    image: "https://i.imgur.com/Ex5x3IU.jpg",
  ),
  ProductModel(
    code: "47",
    title: "Radiant Citrus Eau de Parfum",
    description:
        "Indulge in the essence of summer with this vibrant citrus-scented Eau de Parfum...",
    category: "Accessories",
    image: "https://i.imgur.com/xPDwUb3.jpg",
  ),
  ProductModel(
    code: "48",
    title: "Sleek Olive Green Hardshell Carry-On Luggage",
    description: "Travel in style with our durable hardshell carry-on...",
    category: "Accessories",
    image: "https://i.imgur.com/jVfoZnP.jpg",
  ),
  ProductModel(
    code: "49",
    title: "Chic Transparent Fashion Handbag",
    description:
        "Elevate your style with our Chic Transparent Fashion Handbag...",
    category: "Accessories",
    image: "https://i.imgur.com/Lqaqz59.jpg",
  ),
  ProductModel(
    code: "50",
    title: "Trendy Pink-Tinted Sunglasses",
    description:
        "Step up your style game with these fashionable black-framed, pink-tinted sunglasses...",
    category: "Accessories",
    image: "https://i.imgur.com/0qQBkxX.jpg",
  ),
  ProductModel(
    code: "52",
    title: "produto 1",
    description: "descricao produto 1",
    category: "Clothing",
    image: "https://i.imgur.com/cHddUCu.jpeg",
  ),
];

List<ProductModel> products = [
  ProductModel(
    code: "1",
    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    description:
        "Your perfect pack for everyday use and walks in the forest...",
    category: "Clothing",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
  ),
  ProductModel(
    code: "2",
    title: "Mens Casual Premium Slim Fit T-Shirts",
    description: "Slim-fitting style, contrast raglan long sleeve...",
    category: "Clothing",
    image:
        "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
  ),
  ProductModel(
    code: "3",
    title: "Mens Cotton Jacket",
    description: "Great outerwear jackets for Spring/Autumn/Winter...",
    category: "Clothing",
    image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
  ),
  ProductModel(
    code: "4",
    title: "Mens Casual Slim Fit",
    description:
        "The color could be slightly different between on the screen and in practice...",
    category: "men's clothing",
    image: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
  ),
  ProductModel(
    code: "5",
    title: "John Hardy Women's Legends Naga Gold & Silver Dragon Bracelet",
    description:
        "From our Legends Collection, the Naga was inspired by the mythical water dragon...",
    category: "jewelery",
    image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
  ),
  ProductModel(
    code: "6",
    title: "Solid Gold Petite Micropave",
    description:
        "Satisfaction Guaranteed. Return or exchange any order within 30 days...",
    category: "jewelery",
    image: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
  ),
  ProductModel(
    code: "7",
    title: "White Gold Plated Princess",
    description:
        "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her...",
    category: "jewelery",
    image: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
  ),
  ProductModel(
    code: "8",
    title: "Pierced Owl Rose Gold Plated Stainless Steel Double",
    description: "Rose Gold Plated Double Flared Tunnel Plug Earrings...",
    category: "jewelery",
    image: "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
  ),
  ProductModel(
    code: "9",
    title: "WD 2TB Elements Portable External Hard Drive - USB 3.0",
    description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
  ),
  ProductModel(
    code: "10",
    title: "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
    description:
        "Easy upgrade for faster boot up, shutdown, application load and response...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
  ),
  ProductModel(
    code: "11",
    title:
        "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
    description: "3D NAND flash are applied to deliver high transfer speeds...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
  ),
  ProductModel(
    code: "12",
    title:
        "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
    description:
        "Expand your PS4 gaming experience, Play anywhere Fast and easy setup...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg",
  ),
  ProductModel(
    code: "13",
    title: "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
    description: "21.5 inches Full HD (1920 x 1080) widescreen IPS display...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
  ),
  ProductModel(
    code: "14",
    title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor",
    description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR...",
    category: "electronics",
    image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
  ),
  ProductModel(
    code: "16",
    title:
        "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
    description: "100% POLYURETHANE(shell) 100% POLYESTER(lining)...",
    category: "Clothing",
    image: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
  ),
  ProductModel(
    code: "17",
    title: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
    description: "Lightweight perfet for trip or casual wear...",
    category: "Clothing",
    image: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
  )
];
