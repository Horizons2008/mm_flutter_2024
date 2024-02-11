import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Ctrl_dashboard extends GetxController {
  int currentIndex = 0;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var box = GetStorage();
    String no = await box.read("notif_transac") ?? "";
    if (no.isNotEmpty) {
      currentIndex = 6;

      update();
    }
  }

  changeIndexNav(int tt) {
    currentIndex = tt;
    update();
  }
}
