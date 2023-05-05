import 'package:flutter/material.dart';
import 'package:pet_adobt_app/widget/header_custom.dart';

import '../config/app_color.dart';
import '../config/app_font.dart';
import '../widget/category_custom.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          const HeaderPage(title: 'Pets'),
          const SizedBox(
            height: 15,
          ),
          searchField(),
          const SizedBox(
            height: 15,
          ),
          categories(),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Container searchField() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle: greyTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }

  Column categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 45,
          child: ListView(scrollDirection: Axis.horizontal, children: const [
            CategoryCustom(
              title: '🐈 Cat',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐕 Dog',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐢 Turtle',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐇 Hams',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🕊️ Bird',
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCustom(
              title: '🐟 Fish',
            )
          ]),
        )
      ],
    );
  }

}