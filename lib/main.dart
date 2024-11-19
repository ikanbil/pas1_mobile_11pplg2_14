import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/page/dashboardpage.dart';
import 'package:pas1_mobile_10pplg2_14/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
      ],
    );
  }
}
