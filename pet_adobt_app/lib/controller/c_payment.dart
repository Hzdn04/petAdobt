import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/adobted.dart';
import '../config/session.dart';
import '../pages/home_page.dart';
import '../source/source_adobted.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<String?> token = Session.getToken();

  final _adobted = Adobted().obs;

  int statusPay = 3;

  Future<bool?> makePayment({
    required String amount,
    required String currency,
    required String id,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay: const PaymentSheetGooglePay(
                testEnv: true, merchantCountryCode: 'US'),
            merchantDisplayName: 'Prospects',
            billingDetails: paymentIntentData![''],
            customerId: paymentIntentData!['customer'],
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet(id);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
    return true;
  }

  displayPaymentSheet(String id) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2),
      //     );
      bool? yes = await SourceAdobted.payment(token, statusPay.toString(), id);
      if (yes == true) {
        DInfo.dialogSuccess('Payment SuccessFully');
        DInfo.closeDialog(actionAfterClose: () {
          cHome.indexPage = 2;
          Get.offAll(HomePage());
        });
      }
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51N8EslDYqJ5SohsvZgIn34nC91JZjf0n8OyuM5v7lj7Y5XIWYrjHggrLZnlwKxoukEoDlFY9r9IjiDrQ4U5DVW2D00sUIeiB6f',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
