import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_route.dart';
import '../widget/button_custom.dart';


class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // login(BuildContext context) {
  //   if (formKey.currentState!.validate()) {
  //     UserSource.signIn(controllerEmail.text, controllerPassword.text).then((response) {
  //       if (response['success']) {
  //         DInfo.dialogSuccess(response['message']);
  //         DInfo.closeDialog(actionAfterClose: (){
  //           // Navigator.pushReplacementNamed(context, AppRoute.home);
  //           Get.off(() => HomePage());
  //         });
  //       }else{
  //         DInfo.dialogError(response['message']);
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Image.asset(
                          AppAsset.logo,
                          width: 180,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign In\nTo Your Account',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: controllerEmail,
                          validator: (value) =>
                              value == '' ? "Jangan Kosong" : null,
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
                          validator: (value) =>
                              value == '' ? "Jangan Kosong" : null,
                          obscureText: true,
                          decoration: InputDecoration(
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
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          // child: ButtonCustom(label: 'Login', onTap: () => login(context), marginHorizontal: 80,),
                          child: ButtonCustom(label: 'Login', onTap: () => {
                            Navigator.pushNamed(context, AppRoute.home)
                          }, marginHorizontal: 80,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Create New Account',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ))
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
