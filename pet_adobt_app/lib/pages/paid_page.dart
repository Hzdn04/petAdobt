import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../controller/c_user.dart';
import '../model/adobted.dart';

class PaidPage extends StatelessWidget {
  const PaidPage({super.key, required this.adobted});

  final Adobted adobted;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Payment Confirmation',
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
          adobtDetail(
              context,
              adobted.name!,
              adobted.status!.toInt(),
              adobted.totalPrice!.toDouble(),
              adobted.adobtDate!),
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
          border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1.5)),
        ),
        height: 90,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: TextButton(
          onPressed: () => _launchWhatsApp(),
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Container(
            height: 25,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Contact Admin',
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
  }

  void _launchWhatsApp() async {
    final cUser = Get.put(CUser());
    // Ganti nomor telepon di bawah ini sesuai dengan nomor yang ingin Anda tuju
    String phoneNumber = '+6285755000708';
    String message =
        'Halo, saya ${cUser.data.name} yang ingin mengadobsi, saya akan mengirim bukti transfernya!';

    // var url = 'wa.me/$phoneNumber/?text=${Uri.parse(message)}';

    if (await canLaunchUrl(Uri(scheme: 'sms', path: phoneNumber, queryParameters: <String, String>{
      'body': Uri.encodeComponent(message)
    }))) {
      await launchUrl(Uri(scheme: 'sms', path: phoneNumber, queryParameters: <String, String>{
        'body': Uri.encodeComponent(message)
      }));
    } else {
      throw 'Tidak dapat membuka WhatsApp.';
    }
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Please wait for confirmation of payment from admin. If you have not received confirmation yet, you can contact admin by sending your proof of payment.',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w400,),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: AppColor.secondary,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container adobtDetail(BuildContext context, String name, int status,
      double totalPayment, String adobtDate) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adobt $name Details',
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
              Text('Status', style: Theme.of(context).textTheme.titleMedium),
              Text(
                status == 3 ? 'DONE' : 'CANCELED',
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
              Text('Checkout Date',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(
                AppFormat.date(adobtDate),
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
          const SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Payment',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text(
                NumberFormat.currency(
                        locale: 'id', symbol: 'Rp ', decimalDigits: 0)
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
