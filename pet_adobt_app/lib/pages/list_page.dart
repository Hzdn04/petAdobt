import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/controller/c_pet.dart';
import 'package:pet_adobt_app/controller/c_user.dart';
import 'package:pet_adobt_app/pages/detail_page.dart';
import 'package:pet_adobt_app/widget/header_custom.dart';
import 'package:d_view/d_view.dart';
import 'package:pet_adobt_app/widget/pet_custom.dart';

import '../config/app_color.dart';
import '../config/app_font.dart';
import '../config/app_format.dart';
import '../config/app_route.dart';
import '../model/pet.dart';
import '../widget/category_custom.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final cPet = Get.put(CPet());

  refresh() {
    cPet.getList();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 210,
          backgroundColor: AppColor.bgScaffold,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const HeaderPage(title: 'Pet', subTitle: 'list'),
                const SizedBox(
                  height: 20,
                ),
                searchField(),
                categories()
              ],
            ),
          )),
      body: GetBuilder<CPet>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.listPet.isEmpty) return DView.empty('Empty');
        List<Pet> list = _.category == 'All Pet'
            ? _.listPet
            : _.listPet
                .where((e) => e.petType == cPet.category)
                .toList();
        if (list.isEmpty) {
          return const Center(
            child: Text('Empty',
                style: TextStyle(color: AppColor.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              Pet dataPet = list[index];
              return InkWell(
                onTap: () {
                  // Get.to(() => DetailPage(id: dataPet.id!));
                    // Navigator.pushNamed(context, AppRoute.detail,
                    //     arguments: pet);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(pet: dataPet,)),
                  );

                  // Navigator.pushNamed(context, AppRoute.detail,);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: PetCustom(
                    name: dataPet.race!,
                    gender: true,
                    type: dataPet.petType!,
                    asset: 'assets/cat1.jpg',
                    width: double.infinity,
                    height: 205,
                    price: AppFormat.currency(dataPet.price!.toDouble()),
                  ),
                ),
              );
            },
          ),
        );
      }),
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

  GetBuilder<CPet> categories() {
    return GetBuilder<CPet>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SizedBox(
          height: 45,
          child: ListView.builder(
            itemCount: _.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String category = _.categories[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  0,
                  index == cPet.categories.length - 1 ? 16 : 8,
                  0,
                ),
                child: Material(
                  color: category == _.category ? AppColor.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      cPet.category = category;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: category == _.category ? AppColor.white : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
