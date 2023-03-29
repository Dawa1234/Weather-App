import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:weather_app/measures.dart';
import 'package:weather_app/models/condition.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/repository/weatherRepo.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _locationController = TextEditingController();
  bool isDay = true;

  // for background image
  void checkDayOrNight(String query) {
    WeatherRepoImpl().weatherInformation(query).then((value) {
      if (value!.current!.is_day == 1) {
        setState(() {
          isDay = true;
        });
      } else {
        setState(() {
          isDay = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for initial value
    WeatherRepoImpl().weatherInformation("27.7172,85.3240").then((value) {
      if (value!.current!.is_day == 1) {
        setState(() {
          isDay = true;
        });
      } else {
        setState(() {
          isDay = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
              height: 520,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // Background Image day/night
                      image: isDay
                          ? const AssetImage("assets/images/day.jpg")
                          : const AssetImage("assets/images/night.jpg"))),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    // search/textform bar
                    child: TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintText: "Search by Location Name",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        suffixIcon: Container(
                          width: 106,
                          height: 40,
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                              textColor: Colors.white,
                              color: const Color.fromARGB(255, 255, 172, 100),
                              onPressed: () {
                                setState(() {
                                  checkDayOrNight(_locationController.text);
                                });
                              },
                              child: const Text("Save/Search")),
                        ),
                      ),
                    ),
                  ),
                  gap30,
                  // weather information
                  _WeatherInformation(query: _locationController.text)
                ],
              ),
            ),
            // temperature view
            Positioned(
                bottom: 0,
                child: _BottomInformation(query: _locationController.text)),
            Positioned(
                top: 60,
                child: Container(
                  width: 375,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: const ListTile(
                            leading: Icon(Icons.close),
                            title: Text("Canada"),
                          ),
                        );
                      }),
                ))
          ]),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _WeatherInformation extends StatelessWidget {
  _WeatherInformation({required this.query});

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

// ignore: must_be_immutable
class _BottomInformation extends StatelessWidget {
  _BottomInformation({required this.query});
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
  Widget build(BuildContext context) {
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
          FutureBuilder(
              future: WeatherRepoImpl().weatherInformation(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  ));
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    current = snapshot.data!.current;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // in celsius
                        _temperatureMeter(current!.temp_c!, "C"),
                        // in farenheit
                        _temperatureMeter(current!.temp_f!, "F"),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text("No any request/response"),
                  );
                }
              }),
        ],
      ),
    );
  }
}
