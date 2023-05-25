import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/config/app_format.dart';
import 'package:pet_adobt_app/model/adobted.dart';
import 'package:pet_adobt_app/source/service_payment.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/c_user.dart';

class ConfirmPage extends StatefulWidget {
  ConfirmPage({super.key, required this.adobted});

  final Adobted adobted;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic>? payment;

    // createPaymentIntent() async {
    //   try {
    //     Map<String, dynamic> body = {
    //       'amount': '1000',
    //       'currency': 'USD'
    //     };
    //     http.Response response = await http.post(
    //         Uri.parse(
    //             'https://api.stripe.com/v1/payment-intents'), // Ganti dengan endpoint API Anda untuk membuat payment intent
    //         body: body,
    //         headers: {
    //           'Authorization':
    //               'Bearer sk_test_51N8EslDYqJ5SohsvZgIn34nC91JZjf0n8OyuM5v7lj7Y5XIWYrjHggrLZnlwKxoukEoDlFY9r9IjiDrQ4U5DVW2D00sUIeiB6f',
    //           'Content-Type': 'application/x-www-form-urlencoded'
    //         });

    //     return json.decode(response.body);
    //     // Parse respon dari server Anda
    //     // Dapatkan client secret dari respon dan gunakan untuk mengonfirmasi pembayaran di tahap berikutnya
    //   } catch (e) {
    //     throw Exception(e.toString());
    //     // Tangani kesalahan yang terjadi saat membuat payment intent
    //   }
    // }

    // void displayPaymentSheet() async {
    //   try {
    //     await Stripe.instance.presentPaymentSheet();
    //     print('Done');
    //   } catch (e) {
    //     print('Failed');
    //   }
    // }

    // void makePayment() async {
    //   try {
    //     payment = await createPaymentIntent();

    //     var gpay = const PaymentSheetGooglePay(
    //         merchantCountryCode: "US", currencyCode: "US", testEnv: true);
    //     await Stripe.instance.initPaymentSheet(
    //         paymentSheetParameters: SetupPaymentSheetParameters(
    //             paymentIntentClientSecret: payment!["client_secret"],
    //             style: ThemeMode.light,
    //             merchantDisplayName: "petAdobt",
    //             googlePay: gpay));

    //     displayPaymentSheet();
    //   } catch (e) {
    //     print('Error creating payment method: $e');
    //     // Tangani kesalahan yang terjadi saat membuat payment method
    //   }
    // }

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
          adobtDetail(context, widget.adobted.name!, widget.adobted.status!.toInt(),
              widget.adobted.totalPrice!.toDouble(), widget.adobted.adobtDate!),
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
          child: 
          TextButton(
                onPressed: () => cancelAdobt(widget.adobted.id!),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Container(
                  height: 25,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25),
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
          //         margin:
          //             const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
          //     ButtonCustom(
          //         label: 'Payment',
          //         onTap: () async {
          //           // makePayment();
                    
          //           var items = [
          //             {
          //               'totalPrice': 2,
          //               'petId': "adobted.petId",
          //               'qty': 1
          //             },
          //             {
          //               'totalPrice': 2,
          //               'petId': "adobted.petId",
          //               'qty': 1
          //             }
          //           ];

          //           await StripeService.stripePaymentCheckout(
          //             items,
          //             400,
          //             context,
          //             mounted,
          //             onSuccess: () {
          //               print('SUCCESS');
          //             },
          //             onCencel: () {
          //               print('Cancel');
          //             },
          //             onError: (e) {
          //               print('Error: ' + e.toString());
          //             },
          //           );
          //         },
          //         marginHorizontal: 40),
          //   ],
          // )),
    ));
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
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'BRI, BCA, & BNI',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w300),
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
