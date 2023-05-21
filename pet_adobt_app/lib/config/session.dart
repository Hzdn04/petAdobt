import 'dart:convert';

import 'package:get/get.dart';
import 'package:pet_adobt_app/controller/c_adobted.dart';
import 'package:pet_adobt_app/model/adobted.dart';
import 'package:pet_adobt_app/model/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/c_pet.dart';
import '../controller/c_user.dart';
import '../model/user.dart';

class Session {
  // =============================Manajemen User============================
  static Future<bool> saveUser(User user) async{
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }
    return success;
  }

  static Future<User> getUser() async {
    User user = User();
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('access_token');
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user =User.fromJson(mapUser);
    }
    final cUser = Get.put(CUser());
    cUser.setData(user);
    return user;
  }

  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    final cUser = Get.put(CUser());
    cUser.setData(User());
    return success;
  }


  //=================================Manajemen Pet========================
  static Future<Pet> getPet() async {
    Pet pet = Pet();
    final pref = await SharedPreferences.getInstance();
    String? stringPet = pref.getString('pet');
    if (stringPet != null) {
      Map<String, dynamic> mapPet = jsonDecode(stringPet);
      pet =Pet.fromJson(mapPet);
    }
    final cPet = Get.put(CPet());
    // cPet.setData(pet);
    return pet;
  }



  //============================Manajemen Token==========================

  // static Future<bool> saveToken(token) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('token', token);
    
  //   return token;
  // }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('access_token');
    
    return token;
  }

  static Future<bool> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('access_token');
    
    return success;
  }


//==============================Manajemen Adobted==========================

static Future<bool> saveAdobted(Adobted adobted) async{
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapAdobted = adobted.toJson();
    String stringAdobted = jsonEncode(mapAdobted);
    bool success = await pref.setString('adobted', stringAdobted);
    if (success) {
      final cAdobted = Get.put(CAdobtedList());
      cAdobted.setData(adobted);
    }
    return success;
  }

}