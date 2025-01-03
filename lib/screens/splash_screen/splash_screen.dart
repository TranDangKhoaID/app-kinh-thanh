import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:app_kinh_thanh/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('Kinh thanhs DATA'),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getConfigs();
  }

  /// Get configs
  Future<void> getConfigs() async {
    Get.offAllNamed(AppRoute.homeScreen);
  }
}
