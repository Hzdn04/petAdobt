import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/controller/c_adobted.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_format.dart';
import '../config/session.dart';
import '../controller/c_home.dart';
import '../controller/c_user.dart';
import '../model/pet.dart';
import 'home_page.dart';

class COPage extends StatelessWidget {
  COPage({super.key});

  final cUser = Get.put(CUser());
  final cAdobtedList = Get.put(CAdobtedList());
  final cHome = Get.put(CHome());


  @override
  Widget build(BuildContext context) {
    Pet pet = ModalRoute.of(context)!.settings.arguments as Pet;

    Future<String?> token = Session.getToken();

    // Manual Input
    int tail = 1;
    int totalPayment = pet.price! * tail ;

    addAdobted() async {
      bool? success = await SourceAdobted.add(
        token,
        pet.id.toString(),
        cUser.data.id!.toString(),
        totalPayment.toString(),
      );
      if (success == true) {
        DInfo.dialogSuccess('Adobted ${pet.race} Successfully');
        DInfo.closeDialog(
          actionAfterClose: () {
          cHome.indexPage = 2;
              Get.offAll(() => HomePage());
        }
        );
      } else {
        DInfo.dialogError('Adobted ${pet.race} Failed!');
        DInfo.closeDialog();
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(
            height: 16,
          ),
          adobtDetail(context, pet.petType!, tail, pet.price!.toDouble(), pet.race!, totalPayment.toDouble()),
          const SizedBox(
            height: 16,
          ),
          paymentMethod(context),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(top: BorderSide(color: Colors.grey[100]!, width: 1.5)),
          ),
          height: 90,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: ButtonCustom(
              label: 'Payment', onTap: () => addAdobted(), marginHorizontal: 25)),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!)),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.iconMasteCard,
                  width: 50,
                ),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cUser.data.name!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Balance ${AppFormat.currency(1000000)}',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: AppColor.secondary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container adobtDetail(BuildContext context, String type, int tail, double price,
      String race, double totalPayment) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adobt $type Details',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Type Race', style: Theme.of(context).textTheme.titleMedium),
              Text(
                race,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tail', style: Theme.of(context).textTheme.titleMedium),
              Text(
                tail.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price', style: Theme.of(context).textTheme.titleMedium),
              Text(
                NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(price),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Payment', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
              Text(
                NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(totalPayment),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
