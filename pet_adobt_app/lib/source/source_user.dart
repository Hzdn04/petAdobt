import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/config/api.dart';
import 'package:pet_adobt_app/config/app_request.dart';
import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/model/user.dart';
import 'package:pet_adobt_app/pages/home_page.dart';
import 'package:pet_adobt_app/pages/signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_route.dart';
import '../controller/c_home.dart';

final cHome = Get.put(CHome());
class SourceUser {
  static String tokenAccess = "";

  static Future<String?> login(String email, String password) async {
    // String url = '${Api.user}login.php';
    String url = '${Api.user}login';
    Map? responseBody =
        await AppRequest.post(url, {'email': email, 'password': password});

    // print(responseBody!['data']);
    if (responseBody != null) {
      if (responseBody['message'] == 'User not found') {
        DInfo.dialogError('Email not Found');
        DInfo.closeDialog();
      } else if (responseBody['message'] == 'Invalid credential') {
        DInfo.dialogError('Wrong Password');
        DInfo.closeDialog();
      } else {
        var mapUser = responseBody['data'];
        Session.saveUser(User.fromJson(mapUser));

        var token = responseBody['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', token);
      }
    } else {
      return null;
    }

    return responseBody['access_token'];
  }

  static Future<String?> register(String name, String username, String phone,
      String email, String password) async {
    String url = '${Api.user}register';

    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // print(responseBody!['data']);
    if (responseBody != null) {
      if (responseBody['message'] == 'failed') {
        DInfo.dialogError('Register Failed');
        DInfo.closeDialog();
      } else {
        DInfo.dialogSuccess('SuccessFully Register');
        DInfo.closeDialog(actionAfterClose: () {
          Get.to(() => const SigninPage());
        });
      }
    } else {
      return null;
    }

    return responseBody['message'];
  }

  static Future<String?> edit(
      String username,
      String email,
      String name,
      String age,
      String address,
      String phone,
      String id,
      token,
      BuildContext context) async {
    String url = '${Api.user}edit/$id';

    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    Map? responseBody = await AppRequest.update(url, {
      'username': username,
      'email': email,
      'name': name,
      'age': age,
      'address': address,
      'phone': phone,
      'updated_at': DateTime.now().toIso8601String(),
    }, headers: {
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    if (responseBody == null) return null;

    // ignore: use_build_context_synchronously
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Updated',
      'if there is any alteration or modification in your profile, you must necessary to LogOut!',
      textNo: 'Batal',
      textYes: 'Ya',
    );

    if (yes == true) {
      if (responseBody['message'] == 'User has been updated!') {
        DInfo.dialogSuccess(
            'Updated SuccessFully');
        DInfo.closeDialog(
            durationBeforeClose: const Duration(seconds: 5),
            actionAfterClose: () {
              Session.clearUser();
            });
      } else {
        DInfo.dialogError('Updated Failed');
        DInfo.closeDialog();
      }
    }

    return responseBody['message'];
  }
}
