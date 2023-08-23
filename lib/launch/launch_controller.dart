import 'dart:async';

import 'package:gallery_app/base/app_route.dart';
import 'package:get/get.dart';

class LaunchController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    loading();
  }

  void loading() {
    Timer(const Duration(seconds: 3), () async {
      Get.offAndToNamed(AppRoutes.homePage);
    });
  }
}
