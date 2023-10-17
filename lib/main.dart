import 'package:flutter/material.dart';
import 'package:threescreens/config/router/app_router.dart';
import 'package:threescreens/config/themes/app_themes.dart';
import 'package:threescreens/core/constant/constants.dart';
import 'package:threescreens/injection_container.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: theme(),
      routerConfig: router.config(),
    );
  }
}
