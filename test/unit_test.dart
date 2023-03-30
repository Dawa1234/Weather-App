// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weatherRepo.dart';

void main() {
  test("fetch data from api", () async {
    bool expectedValue = true;
    bool actualValue = false;
    WeatherModel? weatherModel = await WeatherRepoImpl().weatherInformation("");
    if (weatherModel != null) {
      actualValue = true;
    }
    expect(expectedValue, actualValue);
  });
}
