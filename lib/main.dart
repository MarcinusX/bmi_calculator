import 'package:bmi_calculator/input_page/input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styles.dart';

Future<void> main() async {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: mainBlue,
        fontFamily: 'SF Pro Display',
      ),
      home: InputPage(),
    );
  }
}
