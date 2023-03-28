import 'package:weather_app/dataSource/weatherDataSource.dart';
import 'package:weather_app/models/weather.dart';

abstract class WeatherRepository {
  Future<WeatherModel?> weatherInformation(String query);
}

class WeatherRepoImpl extends WeatherRepository {
  @override
  Future<WeatherModel?> weatherInformation(String query) {
    return WeatherDataSource().weatherInformation(query);
  }
}
