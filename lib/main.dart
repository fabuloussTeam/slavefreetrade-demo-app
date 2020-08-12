import 'package:flutter/material.dart';
import 'package:webviewloadsite/features/presentation/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "Webview demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green
        ),
        home: MainPage(),
      );
  }
}