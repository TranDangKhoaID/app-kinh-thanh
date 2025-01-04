import 'package:app_kinh_thanh/controller/network_controller.dart';
import 'package:app_kinh_thanh/locator.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    configureDependencies();
    //Get.lazyPut<HomeController>(() => HomeController());
    Get.put<NetworkController>(
      NetworkController(),
      permanent: true,
    );
  }
}
