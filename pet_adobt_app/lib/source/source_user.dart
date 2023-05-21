import 'package:d_info/d_info.dart';
import 'package:pet_adobt_app/config/api.dart';
import 'package:pet_adobt_app/config/app_request.dart';
import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SourceUser {
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

  static Future<String?> register(String name, String phone, String email,
      String password, String address) async {
    // String url = '${Api.user}login.php';
    String url = '${Api.user}register';

    // File _image;

    // final uri = Uri.parse(url);
    // final request = http.MultipartRequest('POST', uri);
    // final imageFile = await http.MultipartFile.fromPath('profile_image', _image.path);

    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'address': address,
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
        DInfo.closeDialog();
      }
    } else {
      return null;
    }

    return responseBody['message'];
  }

}
