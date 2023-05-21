
import 'package:get/get.dart';

import '../config/session.dart';
import '../model/pet.dart';
import '../source/source_pet.dart';

class CDetailPet extends GetxController {
  final _data = Pet().obs;
  Pet get data => _data.value;

  Future<String?> token = Session.getToken();

  getData(id) async {
    Pet? pet = await SourcePet.detail(token, id);
    _data.value = pet ?? Pet();
    update();
  }
}
