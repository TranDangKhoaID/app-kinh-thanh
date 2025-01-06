import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxBool isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _internetConnectionStream;
  @override
  void onInit() {
    super.onInit();
    _internetConnectionStream = _connectivity.onConnectivityChanged.listen(
      (event) {
        switch (event) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:
            isConnected.value = true;
            break;
          case ConnectivityResult.none:
            isConnected.value = false;
            break;
          default:
            isConnected.value = false;
            break;
        }
      },
    );
  }

  @override
  void onClose() {
    _internetConnectionStream?.cancel();
    super.onClose();
  }
}
