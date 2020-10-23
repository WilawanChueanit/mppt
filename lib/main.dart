import 'package:flutter/material.dart';
import 'package:mppt_esp32/screen/dashboard_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 MPPT',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomepage(title: 'MPPT'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomepage extends StatelessWidget {
  MyHomepage({Key key, this.title}) : super(key: key);
  final String title;
  //Method

  @override
  Widget build(BuildContext context) {
    return DashboardScreen();
  }
}
