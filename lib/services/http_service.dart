import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_spot/model/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _base_url;
  late String _api_key;

  HttpService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<Response?> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {'api_key': _api_key, 'language': 'en-us'};

      if (query != null) {
        _query.addAll(query);
      }

      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print("Unable to perform get request");
      print("DioError: $e");
    }
  }
}
