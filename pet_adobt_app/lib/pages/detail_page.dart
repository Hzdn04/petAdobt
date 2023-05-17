import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_font.dart';
import '../config/app_format.dart';
import '../config/app_route.dart';
import '../widget/button_custom.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final List facilities = [
    {
      'title': 'Male',
      'label': 'Sex',
    },
    {
      'title': 'Black',
      'label': 'Color',
    },
    {
      'title': 'Persian',    
      'label': 'Bread',
    },
    {
      'title': '2Kg',
      'label': 'Weight',
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    // BookingSource.checkIsBooked(cUser.data.id!, hotel.id).then((bookingValue) {
    //   bookedData = bookingValue ?? initBooking;
    // });
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text(
            'Pet Detail',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        // bottomNavigationBar: bookingNow(hotel, context),
        // bottomNavigationBar: Obx(() {
        //   if (bookedData.id == '') return bookingNow(hotel, context);
        //   return viewReceipt(context);
        // }),
        backgroundColor: AppColor.bgScaffold,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage(),
              content(),
            ],
          ),
        ),
        bottomNavigationBar: getAdobt(context));
  }

  Container getAdobt(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1.5)),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: ButtonCustom(
        label: 'BOOKING NOW',
        onTap: () {
          Navigator.pushNamed(context, AppRoute.checkout);
        },
        marginHorizontal: 25,
      ),
    );
  }

  Widget backgroundImage() {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/cat2.jpg'),
        ),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 380),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jack',
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
                        Icons.heart_broken,
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
                    '📍 Malang',
                    style: blackTextStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(2000000),
                    style: blackTextStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              gridFacilities(),
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
                'Berada di jalur jalan provinsi yang menghubungkan Denpasar Singaraja serta letaknya yang dekat dengan Kebun Raya Eka Karya menjadikan tempat Bali.',
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
    );
  }

  GridView gridFacilities() {
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
