import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pet_adobt_app/controller/c_adobted.dart';
import 'package:pet_adobt_app/pages/confirm_page.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../config/app_font.dart';
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
    cAdobtedList.getList();
  }

  Future<String?> token = Session.getToken();

  delete(String id) async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Delete',
      'Are you sure to deleted this adobted history?',
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cUser.data.id == null) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              Session.clearToken();
              Navigator.pushReplacementNamed(context, AppRoute.signin);
            },
            style: TextButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: Container(
              height: 25,
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 190,
            backgroundColor: AppColor.bgScaffold,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  HeaderPage(
                    title: 'History',
                    subTitle: 'Adobted',
                    image: cUser.data.image!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  categories()
                ],
              ),
            )),
        body: GetBuilder<CAdobtedList>(builder: (_) {
          if (_.loading) return DView.loadingCircle();
          if (_.listAdobted.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 220,
                      height: 230,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/no.png'))),
                    ),
                    Text(
                      'Not Transaction',
                      style: blackTextStyle.copyWith(
                          fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            );
          }
          List<Adobted> list = _.status == 3
              ? _.listAdobted
              : _.listAdobted
                  .where((e) => e.status == cAdobtedList.status)
                  .toList();
          return RefreshIndicator(
            onRefresh: () async => refresh(),
            child: ListView(
              children: [
                // Adobted adobted = _.listAdobted[index];
                GroupedListView<Adobted, String>(
                  padding: const EdgeInsets.fromLTRB(25, 0, 16, 25),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  elements: list,
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
                          element.status == 1
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfirmPage(
                                            adobted: element,
                                          )),
                                )
                              : delete(element.id.toString());
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
              ],
            ),
          );
        }),
      );
    }
  }

  Widget item(BuildContext context, Adobted element) {
    // Map user = element.user![index] ?? '';
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
            child: Image.network(
              AppAsset.imageNet,
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
                  element.name ?? '',
                  // user['name'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
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
                color: element.status == 1
                    ? Colors.yellow[800]
                    : element.status == 2
                        ? Colors.green[600]
                        : Colors.red[600],
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(
                element.status == 3
                    ? 'ALL'
                    : element.status == 1
                        ? 'PENDING'
                        : element.status == 2
                            ? 'PAID'
                            : 'CANCELED',
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  GetBuilder<CAdobtedList> categories() {
    return GetBuilder<CAdobtedList>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SizedBox(
          height: 45,
          child: ListView.builder(
            itemCount: _.statuses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              int status = _.statuses[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  0,
                  index == cPet.categories.length - 1 ? 16 : 8,
                  0,
                ),
                child: Material(
                  color: status == _.status ? AppColor.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      cAdobtedList.status = status;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        status == 3
                            ? 'ALL'
                            : status == 1
                                ? 'PENDING'
                                : status == 2
                                    ? 'DONE'
                                    : 'CENCELED',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: status == _.status
                                  ? AppColor.white
                                  : Colors.black,
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
