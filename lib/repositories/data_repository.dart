import 'package:app_kinh_thanh/common/configs.dart';
import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DataRepository implements RestClient {
  /// MARK: - Initials;
  final dio = Dio();
  late RestClient _client;
  //final _appPref = locator<AppPreference>();

  DataRepository() {
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: false,
        error: true,
      ));
    }

    /// Middleware token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          //final token = (await _appPref.getUser())?.accessToken;
          //debugPrint('Authorization token: ${'Bearer $token'}');
          //request.headers['Authorization'] = 'Bearer $token';
          request.headers['Accept'] = 'application/json';
          request.headers['apikey'] = Configs.apiKey;
          handler.next(request);
        },
      ),
    );

    _client = RestClient(dio, baseUrl: Configs.baseUrl);
  }

  @override
  Future<List<BibleModel>> getBibles() {
    return _client.getBibles();
  }
}
