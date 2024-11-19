import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/controller/dashboardcontroller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dashboardcontroller());
  }
}
