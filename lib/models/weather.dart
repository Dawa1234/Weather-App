import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/location.dart';

class WeatherModel {
  Location? location;
  Current? current;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
  }
}
