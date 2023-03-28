import 'package:dio/dio.dart';
import 'package:weather_app/services/connections.dart';

class WeatherDataSource {
  final Dio _httpServices = HttpService().getDioInstance();

  Future weatherInformation() async {
    Response response = await _httpServices
        .get("key=f54ae71c3eeb4051a2664608232703&q=Nepal&aqi=no");
  }
}
