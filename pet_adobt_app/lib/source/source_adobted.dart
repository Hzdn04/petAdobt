import 'package:d_info/d_info.dart';
import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/model/pet.dart';

import '../config/api.dart';
import '../config/app_request.dart';
import '../model/adobted.dart';

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

  static Future<bool?> add(
      token, String petId, String userId, String totalPrice) async {
    String url = '${Api.adobted}create';

    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.post(url, 
    {
      'userId': userId,
      'petId': petId,
      'adobtDate': DateTime.now().toIso8601String(),
      'totalPrice': totalPrice,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    },
    headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    }
    );

    if (responseBody == null) return false;

    if (responseBody['status']) {
      DInfo.dialogSuccess('Berhasil Adobsi');
      DInfo.closeDialog();
    } else {
      DInfo.dialogError('Gagal Adobsi');
      DInfo.closeDialog();
    }

    return responseBody['status'];
  }

  static Future<bool?> delete(token, String idAdobted) async {

    Session.getToken().then((value) {
      tokenAccess = value!;
    });
    
    String url = '${Api.adobted}delete/$idAdobted';
    Map? responseBody = await AppRequest.delete(url,
    headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    }
    );

    if (responseBody == null) return false;

    return responseBody['message'];
  }

  
}
