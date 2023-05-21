import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/controller/c_adobted.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../config/app_route.dart';
import '../config/session.dart';
import '../controller/c_pet.dart';
import '../controller/c_user.dart';
import '../model/adobted.dart';
import '../widget/header_custom.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cUser = Get.put(CUser());
  final cPet = Get.put(CPet());
  final cAdobtedList = Get.put(CAdobtedList());

  refresh() {
    cAdobtedList.getList(cUser.data.id!);
  }

  Future<String?> token = Session.getToken();

  delete(String id) async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Delete',
      'Are you sure to deleted this adobted?',
      textNo: 'Batal',
      textYes: 'Ya',
    );
    if (yes == true) {
      bool? success = await SourceAdobted.delete(token, id);
      if (success == true) {
        refresh();
        DInfo.dialogSuccess('Delete Successfully');
        DInfo.closeDialog();
      } else {
        DInfo.dialogError('Delete Failed!');
        DInfo.closeDialog();
      }
    }
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
          toolbarHeight: 110,
          backgroundColor: AppColor.bgScaffold,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: const [
                SizedBox(
                  height: 15,
                ),
                HeaderPage(title: 'History', subTitle: 'Adobted'),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
      body: GetBuilder<CAdobtedList>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.listAdobted.isEmpty) return DView.empty('Empty');

        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView(
            children: [
              // Adobted adobted = _.listAdobted[index];
               GroupedListView<Adobted, String>(
                padding: const EdgeInsets.fromLTRB(25, 0, 16, 25),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                elements: _.listAdobted,
                groupBy: (element) => element.adobtDate.toString(),
                groupSeparatorBuilder: (String groupByValue) {
                  String date =
                      DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                              groupByValue
                          ? 'Today'
                          : AppFormat.dateMonth(groupByValue);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      date,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                itemBuilder: (context, element) {
                  return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, AppRoute.detailAdobted,
                        //     arguments: element);
                      },
                      child: item(context, element));
                },
                itemComparator: (item1, item2) =>
                    item1.adobtDate!.compareTo(item2.adobtDate!),
                order: GroupedListOrder.DESC, // optional
              )

              // Card(
              //   elevation: 2,
              //   margin: EdgeInsets.fromLTRB(
              //     16,
              //     index == 0 ? 16 : 8,
              //     16,
              //     index == _.listAdobted.length - 1 ? 16 : 8,
              //   ),
              //   child: Row(
              //     children: [
              //       DView.spaceWidth(),
              //       Text(
              //         AppFormat.date(adobted.adobtDate ?? ''),
              //         style: const TextStyle(
              //           color: AppColor.primary,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //       Expanded(
              //         child: Text(
              //           AppFormat.currency(adobted.totalPrice!.toDouble()),
              //           style: const TextStyle(
              //             color: AppColor.primary,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //           ),
              //           textAlign: TextAlign.end,
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () => delete(adobted.id!.toString()),
              //         icon:
              //             Icon(Icons.delete_forever, color: Colors.red[300]!),
              //       ),
              //     ],
              //   ),
              // );
            
          ],),
        );
      }),
    );
  }

  Widget item(BuildContext context, Adobted element) {
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/dog1.jpg',
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element.petId.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(element.totalPrice),
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: true == 'PAID' ? AppColor.secondary : Colors.red,
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text('PAID',
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
