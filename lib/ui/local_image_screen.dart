import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/base/app_route.dart';
import 'package:gallery_app/base/resource.dart';
import 'package:get/get.dart';

class LocalImageScreen extends StatelessWidget {
  LocalImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Photos"),
      ),
      body: FutureBuilder<List<String>>(
          future: getCachedUserInfo(),
          builder: (c, data) {
            if (data.hasData) {
              return data.data!.isNotEmpty?Padding(
                padding: const EdgeInsets.all(5),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    //  controller: controller.scroll,
                    itemCount: data.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.5),
                        child: InkWell(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.scaleDown,
                              image:  FileImage(
                                File(data.data![index]),
                              ),
                              placeholder:  const AssetImage("assets/images/loading_new.gif"),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(AppRoutes.fullScreenCachedImage,
                                arguments: {
                                  "fullImage": data.data![index],
                                });
                          },
                        ),
                      );
                    }),
              ):
              const Center(child: Text("No saved photo"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
