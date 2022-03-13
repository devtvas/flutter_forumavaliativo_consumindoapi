import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/views/home_view.dart';

class AppSrc extends StatelessWidget {
  const AppSrc({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum Avaliativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
