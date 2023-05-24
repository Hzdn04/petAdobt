import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/config/app_color.dart';
import 'package:pet_adobt_app/config/app_font.dart';
import 'package:pet_adobt_app/controller/c_user.dart';
import 'package:pet_adobt_app/pages/change_password_page.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';

import '../config/app_route.dart';
import '../config/session.dart';
import '../widget/header_custom.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    if (cUser.data.id == null) {
      return Scaffold(
        body: Center(
          child: TextButton(
                onPressed: () {
                  Session.clearToken();
                  Navigator.pushReplacementNamed(context, AppRoute.signin);
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Container(
                  height: 25,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        ),
      );
    } else {
      return Scaffold(
        
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          Obx(() {
            return HeaderPage(
                title: 'My Profile', subTitle: cUser.data.username ?? '', image: cUser.data.image ?? 'https://via.placeholder.com/100');
          }),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[150],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  children: [
                    cUser.data.id != null ?
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Obx(() {
                          return Image.network(
                            cUser.data.image ?? 'https://via.placeholder.com/100',
                            width: 152,
                            height: 229,
                            fit: BoxFit.cover,
                          );
                        }))

                        : 

                    Image.asset(
                      'assets/user.png',
                      width: 152,
                      height: 229,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              cUser.data.name ?? '',
                              style: greyTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                            );
                          }),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Email',
                            style: blackTextStyle.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                          Obx(() {
                            return Text(
                              cUser.data.email ?? '',
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            );
                          }),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Age',
                            style: blackTextStyle.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                          Obx(() {
                            return Text(
                              cUser.data.age.toString(),
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            );
                          }),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Phone',
                            style: blackTextStyle.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                          Obx(() {
                            return Text(
                              cUser.data.phone ?? '',
                              style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 210,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[150],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On the web',
                      style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/instagram.png',
                          width: 33,
                          height: 33,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          'assets/facebook.png',
                          width: 33,
                          height: 33,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          'assets/twitter.png',
                          width: 33,
                          height: 33,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          'assets/linkedin.png',
                          width: 33,
                          height: 33,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Address',
                      style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return Text(
                        cUser.data.address ?? '',
                        style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 4,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ButtonCustom(
                  label: 'Edit My profile',
                  onTap: () =>
                      {Navigator.pushNamed(context, AppRoute.editProfile)},
                  marginHorizontal: 85),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const ChangePasswordPage());
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Container(
                  height: 25,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  child: Text(
                    'Change Password',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )
        ],
      ),
    ));
  }
    }
    
}
