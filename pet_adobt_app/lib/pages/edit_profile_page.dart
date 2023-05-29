import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/source/source_user.dart';

import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/c_user.dart';
import '../widget/button_custom.dart';
// import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerUsername = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerAddress = TextEditingController();
  final formKey = GlobalKey<FormState>();

// password visibilty
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

// image picker
  // late XFile image;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   // ignore: deprecated_member_use
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       image = XFile(pickedFile.path);
  //     } else {
  //       // ignore: avoid_print
  //       print('No image selected.');
  //     }
  //   });
  // }

  final cUser = Get.put(CUser());

  Future<String?> token = Session.getToken();

  editProfile() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Canceled',
      'Are you sure to edit your profile?',
      textNo: 'Batal',
      textYes: 'Ya',
    );

    if (yes == true) {
      if (formKey.currentState!.validate()) {
        await SourceUser.edit(
            controllerUsername.text,
            controllerEmail.text,
            controllerName.text,
            controllerAge.text,
            controllerAddress.text,
            controllerPhone.text,
            cUser.data.id.toString(),
            token);
      }
    }
  }

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (cUser.data.id != null) {
      controllerName.text = cUser.data.name!;
      controllerUsername.text = cUser.data.username!;
      controllerEmail.text = cUser.data.email!;
      controllerPhone.text = cUser.data.phone!;
      controllerAddress.text = cUser.data.address ?? '';
      controllerAge.text = cUser.data.age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Update My Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: controllerName,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerUsername,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerPhone,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Number Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerEmail,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Email Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerAge,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 5,
                          cursorHeight: 40,
                          controller: controllerAddress,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                        ),
                        // ignore: unnecessary_null_comparison
                        // image == null
                        //     ? const Text('No image selected.')
                        //     : Image.file(
                        //         image,
                        //         height: 300,
                        //       ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextButton(
                        //   onPressed: getImage,
                        //   child: const Text('Select Image'),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonCustom(
                            label: 'Update',
                            onTap: () => editProfile(),
                            marginHorizontal: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
