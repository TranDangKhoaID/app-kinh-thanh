import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  /// MARK: - Initials;
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/rest/v1/bible?select=*')
  Future<List<BibleModel>> getBibles();
}
