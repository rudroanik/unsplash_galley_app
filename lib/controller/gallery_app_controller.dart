import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/model/gallery_app_model.dart';
import 'package:gallery_app/provider/gallery_app_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryAppController extends GetxController with  ScrollMixin {
  final int perPage = 60;
  int page = 1;
  RxList<GalleryAppModel> photoList = <GalleryAppModel>[].obs;
  RxList<String> cachePhotoList = <String>[].obs;
  bool getFirstData = false;
  bool lastPage = false;
  RxBool isLoading = true.obs;
  StreamSubscription? subscription;


  @override
  void onInit() {
    super.onInit();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        getPhotosList();
      }
    });
  }

  Future<void> getPhotosList() async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "per_page": perPage.toString()
    };
    final value =
        await Get.find<GalleryAppProvider>().getPhotoList(queryParams);
    if (value.code == 200) {
      if (!getFirstData && value.model!.isEmpty) {
      } else if (getFirstData && value.model!.isEmpty) {
        lastPage = true;
      } else {
        getFirstData = true;
        photoList.addAll(value.model!);
      }
    } else {
    }
    isLoading.value = false;
  }
  @override
  Future<void> onEndScroll() async {
    if (!lastPage) {
      page += 1;
      Get.dialog(const Center(child: CircularProgressIndicator()));
      await getPhotosList();
      Get.back();
    }
  }

  @override
  Future<void> onTopScroll() async {
    print("no implementation");
  }


  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }


}
