import 'package:flutter/material.dart';
import 'package:ATM/components/header.dart';
import 'package:ATM/pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      resizeToAvoidBottomPadding: false,  
      appBar: Header(),
      body: MainPage(),
      ),
    );
  }
}

