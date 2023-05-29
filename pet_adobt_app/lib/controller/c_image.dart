import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adobt_app/config/api.dart';

import '../config/session.dart';

class ImagePickerController extends GetxController {
  static String tokenAccess = "";

  // RxString imagePath = ''.obs;

  // Future getImage() async{
  //   final ImagePicker _picker = ImagePicker();
  //   final image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     imagePath.value = image.path.toString();
  //   }
  // }

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => pickedFile;
  final _picker = ImagePicker();

  // Implementing the image picker
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  int id = 1;

  Future<void> upload() async {
   
    http.StreamedResponse response = await updateProfile(_pickedFile, id.toString());
    // _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      // _imagePath=message;
     // _pickedFile = null;
      //await getUserInfo();
      print(message);
    } else {
      print("error posting the image");
    }
    update();

  }

  Future<http.StreamedResponse> updateProfile(
      PickedFile? data, String id) async {
    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${Api.baseUrl}/upload/$id'));
    request.headers.addAll(<String, String>{
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    File? _file = null;

    if (GetPlatform.isMobile && data != null) {
      _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }
    // Map<String, String> _fields = Map();
    // _fields.addAll(<String, String>{
    //   'f_name': userInfoModel.fName,
    //   'email': userInfoModel.email
    // });
    request.fields.addAll(_file as Map<String, String>);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
