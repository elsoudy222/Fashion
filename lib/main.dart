import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/screens/layout_screen/layout_screen.dart';
import 'package:fashion/view/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'data/services/dio_helper.dart';

void main() {

DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColorRed,
      ),
      //home: LayoutScreen(),
      routes: {
        '/': (ctx) => const LoginScreen(),

      },
    );
  }
}
