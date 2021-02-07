import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_snap/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp
]);

SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarColor:Colors.transparent,
  systemNavigationBarColor: Colors.black,
  )

);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotoSnap',
      theme:ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}


