import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';

String secretKey =
    'sk_test_51N8EslDYqJ5SohsvZgIn34nC91JZjf0n8OyuM5v7lj7Y5XIWYrjHggrLZnlwKxoukEoDlFY9r9IjiDrQ4U5DVW2D00sUIeiB6f';
String publishableKey =
    'pk_test_51N8EslDYqJ5Sohsv74kHM4jV6A154Vdp4QZ6NcwCICorDA8FjFlqhHBGlDcTDjAhBRMfQGjnsmDQ10YwBXiTtLfA00SWlxBEqp';

class StripeService {
  static Future<dynamic> createCheckoutSession(
    List<dynamic> adobteds,
    totalAmount,
  ) async {
    final url = Uri.parse('https://api.stripe.com/v1/checkout/sessions');

    String lineItems = "";
    int index = 0;

    for (var value in adobteds) {
      var price = (value['totalPrice'] * 100).round().toString();
      lineItems +=
          "&line_items[$index][price_data][product_data][name]=${value['petId'].toString()}";
      lineItems += "&line_items[$index][price_data][unit_amount]=$price";
      lineItems +=
          "&line_items[$index][price_data][product_data][currency]=EUR";
      lineItems += "&line_items[$index][quantity]=${value['qty'].toString()}";

      index++;
    }

    final response = await http.post(url,
        body:
            'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    return json.decode(response.body)['id'];
  }

  static Future<dynamic> stripePaymentCheckout(
      adobtedItems, subTotal, context, mounted,
      {onSuccess, onCencel, onError}) async {

    var items = [
      {'totalPrice': 2, 'petId': "adobted.petId", 'qty': 1},
      {'totalPrice': 2, 'petId': "adobted.petId", 'qty': 1}
    ];

    final String sessionId =
        await createCheckoutSession(items, subTotal);

    final result = await redirectToCheckout(
        context: context,
        sessionId: sessionId,
        publishableKey: publishableKey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel");

    if (mounted) {
      final text = result.when(
          redirected: () => 'Redirected Successfully',
          success: () => onSuccess(),
          canceled: () => onCencel(),
          error: (e) => onError(e));
      return text;
    }
  }
}
