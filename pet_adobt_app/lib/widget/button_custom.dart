import 'package:flutter/material.dart';

import '../config/app_color.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.label, required this.onTap, required this.marginHorizontal, });
  final String label;
  final Function onTap;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Container(
        height: 25,
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 15),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
