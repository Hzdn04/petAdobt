import 'package:flutter/material.dart';
import 'package:pet_adobt_app/config/app_color.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';
import 'package:pet_adobt_app/widget/pet_custom.dart';

import '../config/app_asset.dart';
import '../config/app_font.dart';
import '../widget/category_custom.dart';

class AdobtPage extends StatelessWidget {
  const AdobtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          header(context),
          const SizedBox(
            height: 24,
          ),
          join(),
          const SizedBox(
            height: 18,
          ),
          categories(),
          const SizedBox(
            height: 18,
          ),
          classRecom(context),
        ],
      ),
    );
  }

  Column classRecom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommendation',
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/class');
              },
              child: const Text('See All',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
            height: 250,
            child: ListView(scrollDirection: Axis.horizontal, children: const [
              PetCustom(
                  name: 'Jack',
                  location: 'Malang',
                  gender: true,
                  asset: 'assets/cat2.jpg',
                  width: 239,
                  height: 80),
              SizedBox(
                width: 16,
              ),
              PetCustom(
                  name: 'Angela',
                  location: 'Malang',
                  gender: false,
                  asset: 'assets/cat1.jpg',
                  width: 239,
                  height: 80),
              SizedBox(
                width: 16,
              ),
              PetCustom(
                  name: 'Jack',
                  location: 'Malang',
                  gender: true,
                  asset: 'assets/dog1.jpg',
                  width: 239,
                  height: 80),
              SizedBox(
                width: 16,
              ),
            ])),
      ],
    );
  }

  Column categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pet ',
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Categories ',
              style: purpleTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 45,
          child: ListView(scrollDirection: Axis.horizontal, children: const [
            CategoryCustom(
              title: '🐈 Cat',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐕 Dog',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐢 Turtle',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐇 Hams',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🕊️ Bird',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐟 Fish',
            )
          ]),
        )
      ],
    );
  }

  Container join() {
    return Container(
      height: 116,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColor.primary),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join our animal\nlovers Community',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                SizedBox(
                  width: 80,
                  height: 27,
                  child: TextButton(
                    onPressed: () => {},
                    style: TextButton.styleFrom(
                        backgroundColor: AppColor.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'Join Now',
                      style: whiteTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Image.asset(
              'assets/woman.png',
              width: 130,
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Row header(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Find Your ',
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Best ',
                  style: purpleTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'Pets 🔥',
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: GestureDetector(
          onTap: () {
            showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(20, 20, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ]).then((value) {
              
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAsset.profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        ),
      ],
    );
  }
}
