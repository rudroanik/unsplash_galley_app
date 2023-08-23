import 'package:flutter/material.dart';
import 'package:gallery_app/base/app_route.dart';
import 'package:gallery_app/controller/gallery_app_controller.dart';
import 'package:get/get.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallery App",
        ),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.localImageScreen);
              },
                child: const Text("Show saved photos",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
          ))
        ],
      ),
      body: GetX<GalleryAppController>(
          initState: (_) => Get.find<GalleryAppController>().getPhotosList(),
          builder: (controller) {
            return controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                :  controller.photoList.isNotEmpty?Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        controller: controller.scroll,
                        itemCount: controller.photoList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 2.5),
                            child: InkWell(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: "assets/images/loading_new.gif",
                                  image:
                                      controller.photoList[index].urls?.thumb ??
                                          "",
                                  placeholderFit: BoxFit.scaleDown,
                                  placeholderScale: 3,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return const Icon(Icons.image_not_supported);
                                  },
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.fullScreenImage,
                                    arguments: {
                                      "fullImage": controller
                                          .photoList[index].urls?.full,
                                      "likes": controller.photoList[index].likes
                                    });
                              },
                            ),
                          );
                        }),
                  ):const Center(child: Text("No data found"),);
          }),
    );
  }
}
