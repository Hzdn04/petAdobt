import 'package:flutter/material.dart';

import '../config/app_font.dart';

class PetCustom extends StatelessWidget {
  final String name;
  final String asset;
  final String price;
  final String type;
  final String gender;
  final double width;
  final double height;

  const PetCustom(
      {super.key,
      required this.name,
      required this.gender,
      required this.asset, required this.width, required this.height, required this.price, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 2, offset: Offset(0, 0.5))
        ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 124,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(asset))),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      gender == 'male' ?
                      const Icon(Icons.male_rounded)
                      :
                      const Icon(Icons.female_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                            price,
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                      Text(
                            type,
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                    ],
                  ),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
