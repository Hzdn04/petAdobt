import 'package:flutter/material.dart';
import 'package:pet_adobt_app/config/app_asset.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';

import '../config/app_route.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 6, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppAsset.bgCat,
                        width: 270,
                        height: 385,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Find your new friends',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Make your life more happy with us to\nhave a little new friends',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
              ButtonCustom(
                  label: 'Get Started',
                  onTap: () => {
                        Navigator.pushReplacementNamed(context, AppRoute.signin)
                      },
                  marginHorizontal: 80)
            ],
          ),
        ),
      ),
    );
  }
}
