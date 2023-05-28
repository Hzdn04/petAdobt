import 'dart:async';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/config/app_format.dart';
import 'package:pet_adobt_app/model/adobted.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/c_home.dart';
import '../controller/c_payment.dart';
import '../controller/c_user.dart';

class ConfirmPage extends StatefulWidget {
  ConfirmPage({super.key, required this.adobted});

  final Adobted adobted;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final cUser = Get.put(CUser());

  final cHome = Get.put(CHome());

  final cPayment = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    Future<String?> token = Session.getToken();

    // Manual Input
    int status = 0;

    cancelAdobt(int id) async {
      bool? yes = await DInfo.dialogConfirmation(
        context,
        'Canceled',
        'Are you sure to cancel this adobted?',
        textNo: 'Batal',
        textYes: 'Ya',
      );

      if (yes == true) {
        await SourceAdobted.cancel(token, status.toString(), id.toString());
      }
    }

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
              widget.adobted.name!,
              widget.adobted.status!.toInt(),
              widget.adobted.totalPrice!.toDouble(),
              widget.adobted.adobtDate!),
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
        child:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextButton(
            //       onPressed: () => cancelAdobt(widget.adobted.id!),
            //       style: TextButton.styleFrom(
            //           backgroundColor: Colors.red,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8))),
            //       child: Container(
            //         height: 25,
            //         margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //         child: Text(
            //           'Cancel',
            //           style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () => _launchWhatsApp(),
            //       style: TextButton.styleFrom(
            //           backgroundColor: Colors.blue,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8))),
            //       child: Container(
            //         height: 25,
            //         margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //         child: Text(
            //           'Confirm',
            //           style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => cancelAdobt(widget.adobted.id!),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Container(
                height: 25,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ButtonCustom(
                label: 'Payment',
                onTap: () => cPayment.makePayment(amount: '1', currency: 'USD', id: widget.adobted.id.toString()),
                marginHorizontal: 40),
          ],
        ),
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    String accountNumberBri = '6465347654567';
    String accountNumberBca = '32435546';
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
                    Image.asset(
                      AppAsset.iconMasteCard,
                      width: 50,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: Text(
                        'A/N Zoe Abbas',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: AppColor.secondary,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/bri.png',
                      width: 80,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: accountNumberBri));
                        final snackBar = SnackBar(
                          backgroundColor: Colors.blue[400],
                          content: const Center(
                              child: Text('Nomor rekening disalin')),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Row(
                        children: [
                          Text(
                            accountNumberBri,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.content_copy),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/bca.png',
                      width: 50,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: accountNumberBca));
                        final snackBar = SnackBar(
                          backgroundColor: Colors.blue[400],
                          content: const Center(
                              child: Text('Nomor rekening disalin')),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Row(
                        children: [
                          Text(
                            accountNumberBca,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.content_copy),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
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
                status == 1 ? 'PENDING' : 'CANCELED',
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
