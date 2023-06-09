
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_font.dart';
import '../config/app_route.dart';
import '../config/session.dart';
import '../controller/c_user.dart';
import '../model/pet.dart';
import '../widget/button_custom.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
  final cUser = Get.put(CUser());
    
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text(
            '${pet.petType} Detail',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        
        backgroundColor: AppColor.bgScaffold,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage(context),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 380),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pet.name ?? 'budi',
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Icon(
                                  Icons.pets_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pet.race!,
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(pet.price),
                              style: blackTextStyle.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        gridFacilities(pet),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Description',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          pet.description ?? '',
                          style: blackTextStyle.copyWith(
                            height: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: 
        // ignore: unnecessary_null_comparison
        cUser.data.id != null ?
          pet.stock! > 0 ? getAdobt(context) : notAdobt(context)
        :
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonCustom(label: 'Login', onTap: () {
                Session.clearToken();
                Navigator.pushReplacementNamed(context, AppRoute.signin);
            }, marginHorizontal: 80),
          )
        );
  }

  Container getAdobt(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1.5)),
      ),
      height: 90,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: 
      ButtonCustom(
        label: 'ADOBT NOW',
        onTap: () {
          Navigator.pushNamed(context, AppRoute.checkout, arguments: pet);
        },
        marginHorizontal: 25,
      ),
    );
  }

  Container notAdobt(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1.5)),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Material(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: const Text(
            'Out of Stock',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Widget backgroundImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(pet.image ?? AppAsset.imageNet),
        ),
      ),
    );
  }

  GridView gridFacilities(Pet pet) {
    final List facilities = [
    {
      'title': pet.sex,
      'label': 'Sex',
    },
    {
      'title': pet.color,
      'label': 'Color',
    },
    {
      'title': pet.stock.toString(),
      'label': 'Available',
    },
    {
      'title': '${pet.weight}Kg',
      'label': 'Weight',
    }
  ];
    return GridView.builder(
      itemCount: facilities.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                facilities[index]['title'],
                style: const TextStyle(fontSize: 14, color: AppColor.primary),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                facilities[index]['label'],
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 20, mainAxisSpacing: 25),
    );
  }
}
