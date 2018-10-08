import 'package:bmi_calculator/input_page/input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styles.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //android:
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      //ios:
      statusBarIconBrightness: Brightness.dark,
    )
  );
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
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
