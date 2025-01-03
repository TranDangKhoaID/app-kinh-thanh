import 'package:app_kinh_thanh/locator.dart';
import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/repositories/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// MARK: - Initials;
  final dataRepository = locator<DataRepository>();
  Rx<BibleModel> bible = BibleModel().obs;
  RxBool isLoading = false.obs;

  //
//   BibleModel? getCurrentBible(DateTime date) {
//     return bibles.value.firstWhere(
//       (bible) => bible.dateTime == date,
//       orElse: () => BibleModel(
//         id: 0,
//         bible: '',
//         original: '',
//         title: '',
//         thought: '',
//         pray: '',
//         end: '',
//       ),
//     );
//   }

  //
  Future<void> getBibles(DateTime date) async {
    try {
      isLoading.value = true;
      final response = await dataRepository.getBibles();
      final item = response.firstWhere(
        (bible) => bible.dateTime == date,
        orElse: () => BibleModel(
          id: 0,
          bible: '',
          original: '',
          title: '',
          thought: '',
          pray: '',
          end: '',
        ),
      );
      bible.value = item;
    } catch (e) {
      debugPrint('Get bibles error ==> $e');
    } finally {
      isLoading.value = false;
    }
  }
}
