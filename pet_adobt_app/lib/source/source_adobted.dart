import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/config/session.dart';

import '../config/api.dart';
import '../config/app_request.dart';
import '../controller/c_home.dart';
import '../model/adobted.dart';
import '../pages/home_page.dart';

final cHome = Get.put(CHome());

class SourceAdobted {
  static String tokenAccess = "";

  static Future<List<Adobted>> adobted(token, String userId) async {
    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    String url = '${Api.adobted}user/$userId';

    Map? responseBody = await AppRequest.get(url, headers: {
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    if (responseBody == null) return [];

    if (responseBody['data'] != null) {
      List list = responseBody['data'];
      return list.map((e) => Adobted.fromJson(e)).toList();
    }

    return [];
  }

  static Future<String?> add(token, String petId, String userId, String name,
      String totalPrice, String status) async {
    String url = '${Api.adobted}create';

    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.post(url, {
      'userId': userId,
      'petId': petId,
      'name': name,
      'adobtDate': DateTime.now().toIso8601String(),
      'totalPrice': totalPrice,
      'status': status,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }, headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    if (responseBody == null) return null;

    // ignore: unnecessary_null_comparison
    if (responseBody['message'] == 'done') {
      DInfo.dialogSuccess('Adobted Successfully');
        DInfo.closeDialog(actionAfterClose: () {
          cHome.indexPage = 2;
          Get.offAll(HomePage());
        });
    } else {
      DInfo.dialogError('Adobted Failed!, please click again');
      DInfo.closeDialog();
    }

    return responseBody['message'];
  }

  static Future<bool?> cancel(
    token,
    String status,
    String id,
  ) async {
    String url = '${Api.adobted}cancel/$id';

    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.update(url, {
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    }, headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    if (responseBody == null) return null;

    if (responseBody['message']) {
      DInfo.dialogSuccess('Cancel SuccessFully');
      DInfo.closeDialog(actionAfterClose: () {
        cHome.indexPage = 2;
        Get.offAll(HomePage());
      });
    } else {
      DInfo.dialogError('Cancel Failed');
      DInfo.closeDialog();
    }

    return responseBody['message'];
  }

  static Future<bool?> payment(
    token,
    String status,
    String id,
  ) async {
    String url = '${Api.adobted}cancel/$id';

    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.update(url, {
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    }, headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    if (responseBody == null) return null;

    return responseBody['message'];
  }

  static Future<bool?> delete(token, String idAdobted) async {
    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    String url = '${Api.adobted}delete/$idAdobted';
    Map? responseBody = await AppRequest.delete(url,
        headers: {'Accept': 'application/json', 'access_token': tokenAccess});

    if (responseBody == null) return false;

    return responseBody['message'];
  }
}
