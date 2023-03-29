import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weatherRepo.dart';

class WeatherProvider extends StateNotifier<WeatherModel> {
  WeatherProvider(super.state);

  Future<WeatherModel?> updateWeather(String query) async {
    await WeatherRepoImpl().weatherInformation(query).then((value) {
      state = value!;
      return state;
    });
    return null;
  }
}

final weatherProvider = StateNotifierProvider<WeatherProvider, WeatherModel>(
    (ref) => WeatherProvider(WeatherModel()));

final weatherInfoProvider = FutureProviderFamily((ref, String query) async {
  WeatherModel? weatherInfo;
  await WeatherRepoImpl().weatherInformation(query).then((value) {
    weatherInfo = value;
    return weatherInfo;
  });
  return weatherInfo;
});
