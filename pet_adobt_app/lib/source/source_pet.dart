import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/model/pet.dart';

import '../config/api.dart';
import '../config/app_request.dart';

class SourcePet {
  static String tokenAccess = "";

  static Future<List<Pet>> pet(token) async {
    Session.getToken().then((value){
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.get(Api.pets, headers: {
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      'access_token': tokenAccess
    });
    
    if (responseBody == null) return [];

    if (responseBody['data'] != null) {
      List list = responseBody['data'];
      return list.map((e) => Pet.fromJson(e)).toList();
    }

    return [];
  }

  static Future<Pet?> detail(
    token,
    int id) async {
    String url = '${Api.pets}info';
    Map? responseBody = await AppRequest.post(url, {
      'id': id,
    },
      headers: {
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      'access_token': tokenAccess
    } 
    );

    if (responseBody == null) return null;

    if (responseBody['data'] != null) {
      var e = responseBody['data'];
      return Pet.fromJson(e);
    }

    return null;
  }

  static Future<List<Pet>> search(
       String race, String price) async {
    String url = '${Api.pets}/search';
    Map? responseBody = await AppRequest.post(url, {
      'race': race,
      'price': price,
    });

    if (responseBody == null) return [];

    if (responseBody['data'] != null) {
      List list = responseBody['data'];
      return list.map((e) => Pet.fromJson(e)).toList();
    }

    return [];
  }
}
