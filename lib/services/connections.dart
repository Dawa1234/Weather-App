import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/services/apiUrls.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

// Dio package
  Dio? _dio;

  final Duration _timeout = const Duration(minutes: 1); //1 min

  Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
    'language': 'en',
  };

  Dio getDioInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: URLs.baseURL,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: headers,
      ),
    );
    _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true));
    return _dio!;
  }
}
