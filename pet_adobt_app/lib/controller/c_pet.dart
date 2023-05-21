import 'package:get/get.dart';
import '../config/session.dart';
import '../model/pet.dart';
import '../source/source_pet.dart';

class CPet extends GetxController{
  final _category = 'All Pet'.obs;
  String get category => _category.value;
  set category(n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
    'All Pet',
    'Cat',
    'Dog',
    'Turtle',
    'Bird',
    'Fish'
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <Pet>[].obs;
  // ignore: invalid_use_of_protected_member
  List<Pet> get listPet => _list.value;

  Future<String?> token = Session.getToken();

  getList() async {
    _loading.value = true;
    update();

    _list.value = await SourcePet.pet(token);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  search(idUser, date) async {
    _loading.value = true;
    update();

    _list.value = await SourcePet.pet(token);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }
}