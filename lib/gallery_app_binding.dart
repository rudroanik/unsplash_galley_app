import 'package:gallery_app/controller/gallery_app_controller.dart';
import 'package:gallery_app/provider/gallery_app_provider.dart';
import 'package:get/get.dart';

class GalleryAppBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryAppProvider());
    Get.lazyPut(() => GalleryAppController());
  }

}