import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/source/source_user.dart';

import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/c_user.dart';
import '../widget/button_custom.dart';
// import 'package:image_picker/image_picker.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final controllerPassword = TextEditingController();
  final controllerPasswordConfrim = TextEditingController();
  final formKey = GlobalKey<FormState>();

// password visibilty
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  final cUser = Get.put(CUser());

  Future<String?> token = Session.getToken();

  changePass() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Canceled',
      'Are you sure to change your password?',
      textNo: 'Batal',
      textYes: 'Ya',
    );

    if (yes == true) {
      if (formKey.currentState!.validate()) {
        await SourceUser.changePassword(controllerPasswordConfrim.text,
            cUser.data.id.toString(), token);
      }
    }
  }

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
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
          'Change My Password',
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
                              hintText: 'Password New',
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
                              hintText: 'Password New Confirmation',
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
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonCustom(
                            label: 'Change',
                            onTap: () => changePass(),
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
