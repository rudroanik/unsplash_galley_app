import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';


class FullScreenCachedImage extends StatelessWidget {
  FullScreenCachedImage({Key? key}) : super(key: key);

  final String fullImage = Get.arguments["fullImage"];




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
                    _showSaveShareText("Share", _shareImage)

                  ],
                ),
              ),
            ])),
      ),
    );
  }

  Widget _getPhotoView() {
    return Center(
      child: PhotoView(
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
        imageProvider: FileImage(File(fullImage)),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }


  void _shareImage() async {
    await Share.shareFiles([fullImage], text: 'Image Shared');
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
