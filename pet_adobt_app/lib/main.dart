import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/pages/checkout_page.dart';
import 'package:pet_adobt_app/pages/history_page.dart';
import 'package:pet_adobt_app/pages/profile_page.dart';
import 'package:pet_adobt_app/pages/signin_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'config/app_color.dart';
import 'config/app_route.dart';
import 'model/user.dart';
import 'pages/edit_profile_page.dart';
import 'pages/home_page.dart';
import 'pages/intro_page.dart';
import 'pages/list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51N8EslDYqJ5Sohsv74kHM4jV6A154Vdp4QZ6NcwCICorDA8FjFlqhHBGlDcTDjAhBRMfQGjnsmDQ10YwBXiTtLfA00SWlxBEqp';
  initializeDateFormatting('id_ID').then((value) => {
    runApp(const MyApp())
  });
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
      // home: FutureBuilder(
      //   future: Session.getUser(),
      //   builder: (context, AsyncSnapshot<User> snapshot) {
      //     if (snapshot.data == null || snapshot.data!.id == null) {
      //           return const IntroPage();
      //         } else {
      //           return HomePage();
      //         }
      //   },
      // ),
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.data == null || snapshot.data!.id == null) {
                return const IntroPage();
              } else {
                return HomePage();
              }
            },
          );
        },
        AppRoute.intro: (context) => const IntroPage(),
        AppRoute.home: (context) => HomePage(),
        AppRoute.list: (context) => const ListPage(),
        AppRoute.history: (context) => const HistoryPage(),
        AppRoute.profile: (context) => ProfilePage(),
        AppRoute.signin: (context) => const SigninPage(),
        // AppRoute.detail: (context) => DetailPage(),
        AppRoute.checkout: (context) => COPage(),
        AppRoute.editProfile: (context) => const EditProfilePage(),
      },
    );
  }
}