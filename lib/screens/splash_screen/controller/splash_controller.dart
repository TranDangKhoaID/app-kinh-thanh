import 'package:app_kinh_thanh/locator.dart';
import 'package:app_kinh_thanh/main.dart';
import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/repositories/data_repository.dart';
import 'package:app_kinh_thanh/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //
  final dataRepository = locator<DataRepository>();

  /// Get configs
  Future<void> getConfigs() async {
    // if (objectBox.isBibleBoxEmpty()) {
    //   List<BibleModel> bibles = await getBibles();
    //   bibles = bibles.map((bible) => bible.copyWith(id: 0)).toList();
    //   objectBox.insertBible(bibles);
    //   print('Bibles box empty()');
    // } else {
    //   print('Bibles box not empty()');
    // }
    Get.offAllNamed(AppRoute.homeScreen);
  }

  //get bibles
  Future<List<BibleModel>> getBibles() async {
    try {
      final response = await dataRepository.getBibles();
      return response;
    } catch (e) {
      debugPrint('Get bibles error ==> $e');
      return [];
    }
  }
}
