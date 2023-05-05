import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../widget/header_custom.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // final cUser = Get.put(CUser());

  // final cHistory = Get.put(CHistory());

  @override
  void initState() {
    // cHistory.getListBooking(cUser.data.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(children: [
          const SizedBox(
            height: 25,
          ),
          const HeaderPage(title: 'History', subTitle: 'Adobted'),
          const SizedBox(
            height: 15,
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
              ),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: AppColor.secondary,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                    'List',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // GetBuilder<CHistory>(builder: (_) {
          //   return GroupedListView<Booking, String>(
          //     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     elements: _.listBooking,
          //     groupBy: (element) => element.date,
          //     groupSeparatorBuilder: (String groupByValue) {
          //       String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
          //               groupByValue
          //           ? 'Today'
          //           : AppFormat.dateMonth(groupByValue);
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 10),
          //         child: Text(
          //           date,
          //           style: Theme.of(context)
          //               .textTheme
          //               .titleMedium!
          //               .copyWith(fontWeight: FontWeight.bold),
          //         ),
          //       );
          //     },
          //     itemBuilder: (context, element) {
          //       return GestureDetector(
          //           onTap: () {
          //             Navigator.pushNamed(context, AppRoute.detailBooking, arguments: element);
          //           }, child: item(context, element));
          //     },
          //     itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
          //     order: GroupedListOrder.DESC, // optional
          //   );
          // })
        ]),
      ),
    );
  }

  Widget item(BuildContext context) {
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
              'booking.cover',
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
                  'booking.name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppFormat.date('12-12-2023'),
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
                color:
                    true == 'PAID' ? AppColor.secondary : Colors.red,
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
