import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_visitor/bloc_observer.dart';
import 'package:my_visitor/core/routes/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/admins/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:my_visitor/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:my_visitor/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/home/presentation/manager/all_products_cubit/all_products_cubit.dart';
import 'package:my_visitor/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:my_visitor/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('cart');

  await Supabase.initialize(
    url: 'https://crgwwfzifppleytrqcmh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNyZ3d3ZnppZnBwbGV5dHJxY21oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMjI0MzksImV4cCI6MjA1NDc5ODQzOX0.cjC38O9-YnZ916IaZDQXee4ONfdnV3Fy14ymnpOAZ4c',
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserever();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AllProductsCubit()..getAllProducts(),
        ),
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,

        darkTheme: ThemeData.light(),

        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute:
            AppRoutes.generateRoute, // Handles dynamic routes with arguments

        routes: AppRoutes.routes,
      ),
    );
  }
}
