import 'package:calculator/news/cubit/news_state.dart';
import 'package:calculator/news/screens/news_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator/homePage.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}