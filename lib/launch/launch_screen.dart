import 'package:flutter/material.dart';
import 'package:gallery_app/launch/launch_controller.dart';
import 'package:get/get.dart';

class LaunchScreen extends GetView<LaunchController> {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: UniqueKey(),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.image_outlined,
                color: Colors.blue,
              ),
              Text(
                "Gallery App",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
