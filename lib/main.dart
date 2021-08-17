// @dart=2.9
import 'package:flutter/material.dart';
import 'package:foodlistdicoding/views/main_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MainScreen(),
      title: new Text(
        'Restaurant List',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
      image: new Image.asset('images/food.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      loadingText: Text('Loading...'),
      photoSize: 120.0,
      loaderColor: Colors.black,
    );
  }
}
