import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_adobt_app/pages/history_page.dart';
import 'package:pet_adobt_app/pages/signin_page.dart';

import 'config/app_color.dart';
import 'config/app_route.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/intro_page.dart';
import 'pages/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColor.bgScaffold,
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        )
      ),
      routes: {
        '/' : (context) => const IntroPage(),
        // AppRoute.intro: (context) => const IntroPage(),
        AppRoute.home: (context) => HomePage(),
        AppRoute.list: (context) => const ListPage(),
        AppRoute.history: (context) => const HistoryPage(),
        AppRoute.signin: (context) => SigninPage(),
        AppRoute.detail: (context) => DetailPage()
      },
    );
  }
}