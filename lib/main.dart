import 'package:flutter/material.dart';
import 'package:gallery_app/base/app_route.dart';
import 'package:gallery_app/gallery_app_binding.dart';
import 'package:gallery_app/launch/launch_binding.dart';
import 'package:gallery_app/launch/launch_screen.dart';
import 'package:gallery_app/ui/full_screen_cached_image.dart';
import 'package:gallery_app/ui/full_screen_image.dart';
import 'package:gallery_app/ui/gallery_app_screen.dart';
import 'package:gallery_app/ui/internate_connection_widget.dart';
import 'package:gallery_app/ui/local_image_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gallery App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: AppRoutes.launchPage,
            getPages: [
              GetPage(name: AppRoutes.launchPage, page: () => const LaunchScreen(), binding: LaunchBindings()),
              GetPage(name: AppRoutes.homePage, page: () => const GalleryScreen(), binding: GalleryAppBinding()),
              GetPage(name: AppRoutes.fullScreenImage, page: () => FullScreenImage()),
              GetPage(name: AppRoutes.localImageScreen, page: () => LocalImageScreen()),
              GetPage(name: AppRoutes.fullScreenCachedImage, page: () => FullScreenCachedImage()),
            ],
          ),
        ),
        InternetConnectionWidget()
      ],
    );
  }
}
