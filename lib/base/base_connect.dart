import 'package:gallery_app/base/env_config.dart';
import 'package:get/get.dart';

class BaseConnect extends GetConnect {

  String token = "Vv12itar70D4ciBi4kc2CSSutCeyBpYAygdKrmksg9A";

  @override
  void onInit() {
    httpClient.timeout = const Duration(minutes: 1);
    httpClient.baseUrl = EnvConfig.baseUrl;

    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers.addAll({
        'Authorization':
            "Client-ID $token",
      });
      return request;
    });
  }
}
