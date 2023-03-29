// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:weather_app/models/condition.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/repository/weatherRepo.dart';

class WeatherInformation extends StatelessWidget {
  WeatherInformation({super.key, required this.query});

  // styling text
  TextStyle textStyle(
      {required double fontSize,
      required FontWeight fontWeight,
      Color color = Colors.white}) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  // variables
  String query;
  Location? location;
  Current? current;
  Condition? condition;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: WeatherRepoImpl().weatherInformation(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              location = snapshot.data!.location;
              current = snapshot.data!.current;
              condition = snapshot.data!.current!.condition!;
              // main weather content
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Day/Night
                    Wrap(
                      children: [
                        Text(
                          current!.is_day! == 1 ? "Day" : "Night",
                          style: textStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            height: 25,
                            width: 25,
                            margin: const EdgeInsets.only(left: 8),
                            child: current!.is_day! == 1
                                ? const Icon(
                                    Icons.wb_sunny,
                                    color: Colors.yellow,
                                  )
                                : const Icon(
                                    Icons.nightlight_round,
                                    color: Colors.yellow,
                                  )),
                      ],
                    ),
                    // weather names (cloudy,clear, ...)
                    Text(condition!.text!,
                        style: textStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        )),
                    // location
                    Text(
                      "${location!.name}, ${location!.country}",
                      style: textStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // temperature
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: current!.temp_c.toString(),
                            style: textStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: "°c",
                            style: textStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: current!.is_day! == 1
                                    ? Colors.white
                                    : Colors.orange)),
                      ]),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("No data found",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              );
            }
          } else {
            return const Center(
              child: Text("No any request/response"),
            );
          }
        });
  }
}
