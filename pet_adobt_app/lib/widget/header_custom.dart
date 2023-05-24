import 'package:flutter/material.dart';

import '../config/app_route.dart';
import '../config/session.dart';

class HeaderPage extends StatelessWidget {
   HeaderPage({super.key, required this.title, this.subTitle = "", required this.image, });

  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              subTitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(20, 20, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ]).then((value) {
              Session.clearUser();
              Session.clearToken();
              Navigator.pushReplacementNamed(context, AppRoute.signin);
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ]),
    );
  }
}
