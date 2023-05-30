import 'dart:convert';
import 'dart:io';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adobt_app/config/app_color.dart';
import 'package:pet_adobt_app/config/app_font.dart';
import 'package:pet_adobt_app/controller/c_user.dart';
import 'package:pet_adobt_app/pages/change_password_page.dart';
import 'package:pet_adobt_app/widget/button_custom.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adobt_app/config/api.dart';

import '../config/app_route.dart';
import '../config/session.dart';
import '../widget/header_custom.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cUser = Get.put(CUser());

  // ignore: unused_field
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  // Implementing the image picker
  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  Future<bool?> upload() async {
    bool success = false;

    http.StreamedResponse response =
        await updateProfile(_pickedFile, cUser.data.id.toString());

    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      Map map = jsonDecode(await response.stream.bytesToString());
      // String message = map["message"];

      success = true;
      DInfo.dialogSuccess('Upload Successful. Please logOut for the latest update!');
      DInfo.closeDialog();
    } else {
      DInfo.dialogError('Upload Image Failed!, please click again');
      DInfo.closeDialog();
    }

    return success;
  }

  static String tokenAccess = "";

  Future<http.StreamedResponse> updateProfile(
      PickedFile? data, String id) async {
    Session.getToken().then((value) {
      tokenAccess = value!;
    });

    http.MultipartRequest request =
        http.MultipartRequest('PUT', Uri.parse('${Api.user}upload/$id'));
    request.headers.addAll(<String, String>{
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      'access_token': tokenAccess
    });

    // File? _file = null;

    if (GetPlatform.isMobile && data != null) {
      File? _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    http.StreamedResponse response = await request.send();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    if (cUser.data.id == null) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              Session.clearToken();
              Navigator.pushReplacementNamed(context, AppRoute.signin);
            },
            style: TextButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: Container(
              height: 25,
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              return HeaderPage(
                  title: 'My Profile',
                  subTitle: cUser.data.username ?? '',
                  image: cUser.data.image ?? 'https://via.placeholder.com/100');
            }),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[150],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: _pickedFile != null
                                    ? Image.file(
                                        File(_pickedFile!.path),
                                        width: 152,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          cUser.data.image ?? '',
                                          width: 152,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              // GetBuilder<ImagePickerController>(builder: (_) {
                              //   return ClipRRect(
                              //     borderRadius: BorderRadius.circular(25),
                              //     child: Get.find<ImagePickerController>().pickedFile != null
                              //         ? Image.file(
                              //             File(Get.find<ImagePickerController>().pickedFile!.path),
                              //             width: 152,
                              //             height: 229,
                              //             fit: BoxFit.cover,
                              //           )
                              //         :
                              //         CircleAvatar(
                              //             backgroundColor: Colors.transparent,
                              //             radius: 80,
                              //             child: Image.network(
                              //               cUser.data.image ?? '',
                              //               fit: BoxFit.cover,
                              //             ),
                              //           ),
                              //     // CircleAvatar(
                              //     //     radius: 80,
                              //     //     backgroundColor: Colors.transparent,
                              //     //     backgroundImage: cImage
                              //     //             .imagePath.isNotEmpty
                              //     //         ? FileImage(File(
                              //     //             cImage.imagePath.toString()))
                              //     //         : null)
                              //     //     Image.network(
                              //     //   (cImage.imagePath.isNotEmpty
                              //     //       ? FileImage(
                              //     //           File(cImage.imagePath.toString()))
                              //     //       : null) as String,
                              //     //   width: 152,
                              //     //   height: 229,
                              //     //   fit: BoxFit.cover,
                              //     // ),
                              //   );
                              // }),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: TextButton(
                                    onPressed: () {
                                      // cImage.getImage();
                                      _pickImage();
                                    },
                                    child: const Icon(
                                      Icons.photo_camera,
                                      size: 30,
                                    )),
                              )
                            ],
                          ),
                          _pickedFile != null
                              ? TextButton(
                                  onPressed: () {
                                    upload();
                                  },
                                  child: const Icon(
                                    Icons.upload,
                                    size: 30,
                                  ))
                              : const SizedBox(
                                  height: 2,
                                )
                        ],
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Text(
                                cUser.data.name ?? '',
                                style: greyTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                              );
                            }),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Email',
                              style: blackTextStyle.copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            Obx(() {
                              return Text(
                                cUser.data.email ?? '',
                                style: greyTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              );
                            }),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Age',
                              style: blackTextStyle.copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            Obx(() {
                              return Text(
                                cUser.data.age.toString(),
                                style: greyTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              );
                            }),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Phone',
                              style: blackTextStyle.copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            Obx(() {
                              return Text(
                                cUser.data.phone ?? '',
                                style: greyTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  height: 210,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[150],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'On the web',
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/instagram.png',
                            width: 33,
                            height: 33,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            'assets/facebook.png',
                            width: 33,
                            height: 33,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            'assets/twitter.png',
                            width: 33,
                            height: 33,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            'assets/linkedin.png',
                            width: 33,
                            height: 33,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Address',
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Text(
                          cUser.data.address ?? '',
                          style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 4,
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonCustom(
                    label: 'Edit My profile',
                    onTap: () =>
                        {Navigator.pushNamed(context, AppRoute.editProfile)},
                    marginHorizontal: 85),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const ChangePasswordPage());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Container(
                    height: 25,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    child: Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      ));
    }
  }
}
