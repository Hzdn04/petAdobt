import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/source/source_user.dart';

import '../config/app_color.dart';
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
  final controllerPassword = TextEditingController();
  final controllerPasswordConfrim = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
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

  register() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.register(
          controllerName.text,
          controllerPhone.text,
          controllerEmail.text, 
          controllerPasswordConfrim.text,
          controllerAddress.text
          );
    }
  }

  //decrypt password
  // String decryptPassword(String password) {
    // Lakukan proses enkripsi pada password menggunakan bcrypt
    // String salt = bcrypt.genSalt();
    // String hashedPassword = bcrypt.hashpw(password, salt);

    // return hashedPassword;
  // }

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (cUser.data != null) {
      controllerName.text = cUser.data.name!;
      controllerEmail.text = cUser.data.email!;
      controllerPhone.text = cUser.data.phone!;
      controllerAddress.text = cUser.data.address!;
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
                          controller: controllerPhone,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Phone',
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
                          controller: controllerPassword,
                          maxLength: 6,
                          validator: (value) =>
                              value == '' ? "Don't be empty" : null,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: Colors.grey,
                                splashRadius: 1,
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: togglePassword,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Password',
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
                          controller: controllerPasswordConfrim,
                          maxLength: 6,
                          validator: (value) {
                            if (value == '') {
                              return "Don't be empty";
                              // ignore: unrelated_type_equality_checks
                            } else if (value != controllerPassword.text) {
                              return "passwords are not the same";
                            } else {
                              return null;
                            }
                          },
                          obscureText: !passwordConfirmVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: Colors.grey,
                                splashRadius: 1,
                                icon: Icon(passwordConfirmVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    passwordConfirmVisible =
                                        !passwordConfirmVisible;
                                  });
                                },
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: 'Password Confirmation',
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
                            onTap: () => register(),
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
