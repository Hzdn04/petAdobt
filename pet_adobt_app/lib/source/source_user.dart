import 'package:d_info/d_info.dart';
import 'package:pet_adobt_app/config/api.dart';
import 'package:pet_adobt_app/config/app_request.dart';
import 'package:pet_adobt_app/config/session.dart';
import 'package:pet_adobt_app/model/user.dart';

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
        // Session.saveToken(mapUser);
      }
    } else {
      return null;
    }

    return responseBody['access_token'];
  }
}
