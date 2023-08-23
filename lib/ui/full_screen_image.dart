import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/base/resource.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';


class FullScreenImage extends StatelessWidget {
  FullScreenImage({Key? key}) : super(key: key);

  final String fullImage = Get.arguments["fullImage"];
  final int like = Get.arguments["likes"];
  RxBool isDownloaded = false.obs;
  File? imageFile;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Colors.black,
            child: Stack(children: [
              _getPhotoView(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Obx(() => isDownloaded.isTrue
                        ? _showSaveShareText("Share", _shareImage)
                        : const SizedBox()),
                    _showSaveShareText("Save", _downloadImage)
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    "Likes $like",
                    style: const TextStyle(color: Colors.white),
                  ))
            ])),
      ),
    );
  }

  Widget _getPhotoView() {
    return Center(
      child: PhotoView(
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
        imageProvider: NetworkImage(fullImage),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _downloadImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final response = await Dio().get(fullImage,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final imageName = path.basename(fullImage);
      final appDir = await path_provider.getApplicationDocumentsDirectory();

      final localPath = path.join(appDir.path, "$imageName.jpg");
      imageFile = File(localPath);

      if (response.statusCode == 200) {
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
            name: fullImage.split("/").last);
        await imageFile?.writeAsBytes(response.data);

       List<String> cacheImageList =  await getCachedUserInfo();
        List<String> list =[];

       list.addAll(cacheImageList);
        list.add(imageFile!.path);
        cacheUserInfo(list);
        if (Get.isDialogOpen == true) {
          Get.back();
          isDownloaded.value = true;
          Get.snackbar("Saved", "Image saved successfully",
              colorText: Colors.white);
        }
      }
    } else {
      Get.snackbar("Permission Denied", "Please allow permission to save image",
          colorText: Colors.white);
    }
  }

  void _shareImage() async {
    await Share.shareFiles([imageFile!.path], text: 'Image Shared');
  }

  _showSaveShareText(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
