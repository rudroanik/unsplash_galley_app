import 'package:gallery_app/launch/launch_controller.dart';
import 'package:get/get.dart';

class LaunchBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(LaunchController());

  }

}