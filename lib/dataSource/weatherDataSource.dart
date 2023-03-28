import 'package:dio/dio.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/connections.dart';

class WeatherDataSource {
  final Dio _httpServices = HttpService().getDioInstance();

  Future<WeatherModel?> weatherInformation(String query) async {
    try {
      if (query.isEmpty) {
        Response response = await _httpServices
            .get("key=f54ae71c3eeb4051a2664608232703&q=27.7172,85.3240&aqi=no");
        WeatherModel weatherModel = WeatherModel.fromJson(response.data);
        return weatherModel;
      } else {
        Response response = await _httpServices
            .get("key=f54ae71c3eeb4051a2664608232703&q=$query&aqi=no");
        WeatherModel weatherModel = WeatherModel.fromJson(response.data);
        return weatherModel;
      }
    } catch (e) {
      return null;
    }
  }
}
