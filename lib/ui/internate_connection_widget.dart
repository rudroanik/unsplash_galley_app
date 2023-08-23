import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectionWidget extends StatelessWidget{

  final _connectivity = Connectivity();

  InternetConnectionWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      builder: (context, futureData) {
        if (futureData.data != null) {
          return StreamBuilder<ConnectivityResult>(
            initialData: futureData.data,
            stream: _connectivity.onConnectivityChanged,
            builder: (context, data) {
              if (data.data == null) {
                _connectivity.checkConnectivity();
              }
              if (data.data == null ||
                  (data.hasData && data.data != ConnectivityResult.none)) {
                return const SizedBox();
              }
              return WidgetsApp(
                debugShowCheckedModeBanner: false,
                builder: (context, _) {
                  return Container(
                    color: Colors.redAccent,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.wifi_off,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No Internet Connection",
                            style:TextStyle(
                                fontSize: 14,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                },
                color: Colors.blue,
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
      future: _connectivity.checkConnectivity(),
    );
  }

}