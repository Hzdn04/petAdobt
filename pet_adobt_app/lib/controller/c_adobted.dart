
import 'package:get/get.dart';
import 'package:pet_adobt_app/source/source_adobted.dart';

import '../config/session.dart';
import '../model/adobted.dart';
import 'c_user.dart';

class CAdobtedList extends GetxController{
  // final Rx<Adobted> _adobtedData = initAdobted.obs;
  // Adobted get adobtedData => _adobtedData.value;
  // set adobtedData(Adobted n) => _adobtedData.value = n;

  final _status = 3.obs;
  int get status => _status.value;
  set status(n) {
    _status.value = n;
    update();
  }

  List<int> get statuses => [
    3,
    1,
    2,
    0
  ];

  final cUser = Get.put(CUser());

  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Adobted>[].obs;
  // ignore: invalid_use_of_protected_member
  List<Adobted> get listAdobted => _list.value;
  setData(n) => _list.value=n;

  Future<String?> token = Session.getToken();

  getList() async {
    _loading.value = true;
    update();

    _list.value = await SourceAdobted.adobted(token, cUser.data.id.toString());
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }
  
}