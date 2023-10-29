import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'splash_page.dart';
import 'Home_page.dart';
import 'package:flutter_application_1/create_user_screen.dart';
import 'user_detail_screen.dart';
import 'not_found_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
  home: SplashPage(),
  getPages: [
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/create', page: () => createuserscreen()),
    GetPage(name: '/userDetail', page: () => UserDetailScreen()),
    GetPage(name: '/notfoundscreen', page: () => NotFoundScreen()),
  ],
);
}
}