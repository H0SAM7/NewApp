import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_visitor/bloc_observer.dart';
import 'package:my_visitor/core/routes/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_visitor/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:my_visitor/firebase_options.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding before async calls
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    Bloc.observer = SimpleBlocObserever();
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        darkTheme: ThemeData.dark(), // Dark Theme

        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          fontFamily: GoogleFonts.manrope().fontFamily,
        ),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
