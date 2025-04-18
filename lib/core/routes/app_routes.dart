import 'package:flutter/material.dart';
import 'package:my_visitor/bottom_navv_bar.dart';
import 'package:my_visitor/features/Notifications/services/send_notifications_view.dart';
import 'package:my_visitor/features/Notifications/views/notifi_view.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/admins/presentation/views/add_products_view.dart';
import 'package:my_visitor/features/admins/presentation/views/delete_view.dart';
import 'package:my_visitor/features/admins/presentation/views/update_view.dart';
import 'package:my_visitor/features/auth/screens/forget_view.dart';
import 'package:my_visitor/features/auth/screens/login_view.dart';
import 'package:my_visitor/features/auth/screens/register_view.dart';
import 'package:my_visitor/features/cart/views/cart_view.dart';
import 'package:my_visitor/features/home/presentation/views/categories_view.dart';
import 'package:my_visitor/features/home/presentation/views/category_products_view.dart';
import 'package:my_visitor/features/home/presentation/views/home_view.dart';
import 'package:my_visitor/features/home/presentation/views/product_details_view.dart';
import 'package:my_visitor/features/home/presentation/views/settings_view.dart';
import 'package:my_visitor/features/splash/first_screen.dart';
import 'package:my_visitor/profile/views/my_products_view.dart';
import 'package:my_visitor/profile/views/profile_screen.dart';

abstract class AppRoutes {
  //     BottomNavigator
  // BottomNavigator.id: (context) => const BottomNavigator(),
  static String? initialRoute = FirstScreen.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    BottomNavigator.id: (context) => const BottomNavigator(),
    //navigation bar #########
    HomeView.id: (context) => const HomeView(),
    RegisterView.id: (context) => const RegisterView(),
    LoginView.id: (context) => const LoginView(),
    ForgetView.id: (context) => const ForgetView(),
    AddProductsView.id: (context) => const AddProductsView(),
    SettingsScreen.id: (context) => const SettingsScreen(),
    CategoriesView.id: (context) => const CategoriesView(),
    CartView.id: (context) => const CartView(),
    CategoryProductsView.id: (context) => const CategoryProductsView(),
    NotifiView.id: (context) => const NotifiView(),
    FirstScreen.id: (context) => const FirstScreen(),
    DeleteProductsView.id: (context) =>  DeleteProductsView(),
    SendNotifactionsSendView.id: (context) =>  SendNotifactionsSendView(),
    UpdateProductsView.id: (context) =>  UpdateProductsView(),
    ProfileScreen.id: (context) =>  ProfileScreen(),

    MyProductsView.id: (context) =>  MyProductsView(),


    
  };
  // Handle routes that require arguments
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case CategoriesView.id :
      //   final categoryName = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (context) => CategoryProductsView(categoryName: categoryName),
      //   );

      case DetailsPage.id:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(productModel: product),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page Not Found'),),
          ),
        );
    }
  }
}
