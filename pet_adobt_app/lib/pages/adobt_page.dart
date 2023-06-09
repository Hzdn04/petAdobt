import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/config/app_color.dart';
import 'package:pet_adobt_app/controller/c_pet.dart';
import 'package:pet_adobt_app/controller/c_user.dart';
import 'package:pet_adobt_app/model/pet.dart';
import 'package:pet_adobt_app/widget/pet_custom.dart';

import '../config/app_font.dart';
import '../config/app_route.dart';
import '../config/session.dart';
import '../widget/category_custom.dart';
import 'detail_page.dart';

class AdobtPage extends StatelessWidget {
  const AdobtPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cPet = Get.put(CPet());

    final cUser = Get.put(CUser());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          header(context, cUser),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'News ',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '5 Pets',
                    style: purpleTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              cUser.data.id != null ?

              SizedBox(
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: petRecom(cPet),
                  ))

              :

              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  GetBuilder<CPet> petRecom(CPet cPet) {
    bool isLoading = true;
    return GetBuilder<CPet>(builder: (_) {
      List<Pet> list = _.listPet;

      if (list.isEmpty) {
        return Center(
          child: LoadingScreen(isLoading: isLoading),
        );
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        reverse: true,
        itemCount: list.length < 5 ? list.length : 5,
        itemBuilder: (context, index) {
          Pet pet = list[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            pet: pet,
                          )),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  0,
                  index == 0 ? 0 : 1,
                  12,
                  index == list.length - 1 ? 3 : 1,
                ),
                child: PetCustom(
                    name: pet.race ?? '',
                    gender: pet.sex.toString().toLowerCase(),
                    asset: pet.image!,
                    width: 300,
                    height: 220,
                    price: NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(pet.price),
                    type: pet.race!),
              ));
        },
      );
    });
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

  Row header(BuildContext context, CUser cUser) {
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
                Session.clearUser();
                Session.clearToken();
                Navigator.pushReplacementNamed(context, AppRoute.signin);
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: 

              cUser.data.id != null ?

              Image.network(
                cUser.data.image ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )

              :

              Image.asset(
                'assets/user.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final bool isLoading;

  const LoadingScreen({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              width: 300,
              height: 210,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 0.5))
              ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 124,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/loading.gif'))),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 180,
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 180,
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
