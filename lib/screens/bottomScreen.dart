import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:weather_app/measures.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/provider/weatherProvider.dart';

class BottomInformation extends ConsumerWidget {
  BottomInformation({super.key, required this.query});
  // variables
  String query;
  Current? current;
  final TextStyle _textStyle = const TextStyle(
    shadows: [
      Shadow(color: Colors.black, offset: Offset(0, -20), blurRadius: 1)
    ],
    fontWeight: FontWeight.w500,
    color: Colors.transparent,
    decoration: TextDecoration.underline,
    decorationColor: Color.fromARGB(255, 184, 184, 184),
    decorationThickness: 3,
    decorationStyle: TextDecorationStyle.solid,
  );

  // show temperature function
  // here, speed indicates the temperature
  SizedBox _temperatureMeter(double temperature, String degree) {
    return SizedBox(
        height: 150,
        width: 150,
        child: KdGaugeView(
          innerCirclePadding: 40,
          gaugeWidth: 15,
          duration: const Duration(seconds: 2),
          speedTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          speed: temperature,
          minSpeed: -40,
          maxSpeed: degree == "C" ? 60 : 140,
          animate: true,
          alertSpeedArray:
              degree == "C" ? const [-40, 7, 24] : const [-40, 50, 75],
          alertColorArray: const [
            Color.fromARGB(255, 65, 217, 222),
            Colors.orange,
            Colors.red
          ],
          minMaxTextStyle: const TextStyle(color: Colors.transparent),
          unitOfMeasurement: "°$degree",
          unitOfMeasurementTextStyle:
              const TextStyle(fontSize: 20, color: Colors.black),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      width: fullWidth(context),
      height: 257,
      child: Column(
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              "Temperature View",
              style: _textStyle,
            ),
          ),
          gap30,
          ref.watch(weatherInfoProvider(query)).when(data: (data) {
            if (data != null) {
              current = data.current;
            }
            return data != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // in celsius
                      _temperatureMeter(current!.temp_c!, "C"),
                      // in farenheit
                      _temperatureMeter(current!.temp_f!, "F"),
                    ],
                  )
                : const Center(
                    child: Text(
                    "No data",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ));
          }, error: (error, stackTrace) {
            return const Center(
              child: Text("No data"),
            );
          }, loading: () {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            ));
          }),
          // FutureBuilder(
          //     future: WeatherRepoImpl().weatherInformation(query),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //             child: CircularProgressIndicator(
          //           color: Colors.orange,
          //         ));
          //       } else if (snapshot.connectionState == ConnectionState.active ||
          //           snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.hasData) {
          //           current = snapshot.data!.current;
          //           return Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               // in celsius
          //               _temperatureMeter(current!.temp_c!, "C"),
          //               // in farenheit
          //               _temperatureMeter(current!.temp_f!, "F"),
          //             ],
          //           );
          //         } else {
          //           return const Center(
          //             child: Text(
          //               "No data found",
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.orange),
          //             ),
          //           );
          //         }
          //       } else {
          //         return const Center(
          //           child: Text("No any request/response"),
          //         );
          //       }
          //     }),
        ],
      ),
    );
  }
}
