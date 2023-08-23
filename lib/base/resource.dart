import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Resource<T> {
  ResourceStatus status;
  T? model;
  String? message;
  int code;

  Resource(
      {this.model,
      this.message,
      this.status = ResourceStatus.EMPTY,
      this.code = 0});

  @override
  String toString() {
    return 'Resource{status: $status, model: $model, message: $message, code: $code}';
  }
}

enum ResourceStatus { EMPTY, LOADING, SUCCESS, FAILED }

Future<void> cacheUserInfo(List<String> images) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("imageList", jsonEncode(images));
}
Future<List<String>> getCachedUserInfo() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final List<dynamic> jsonData = jsonDecode(preferences.getString('imageList') ?? '[]');
  List<String> list = jsonData.map<String>((jsonItem) {
    return jsonItem;
  }).toList();
  return list;


}
