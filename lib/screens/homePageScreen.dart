import 'package:flutter/material.dart';
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
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: isDay
                            ? const AssetImage("assets/images/day.jpg")
                            : const AssetImage("assets/images/night.jpg"))),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
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
                                color: const Color.fromARGB(255, 183, 183, 183),
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
                    _WeatherInformation(query: _locationController.text)
                  ],
                ),
              ),
              _BottomInformation(query: _locationController.text)
            ]),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _WeatherInformation extends StatelessWidget {
  TextStyle textStyle(
      {required double fontSize, required FontWeight fontWeight}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: Colors.white);
  }

  String query;
  _WeatherInformation({required this.query});
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          current!.is_day! == 1 ? "Day" : "Night",
                          style: textStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                    Text(condition!.text!,
                        style: textStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        )),
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
                            )),
                      ]),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("No data found"),
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
  TextStyle textStyle(
      {required double fontSize, required FontWeight fontWeight}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: Colors.black);
  }

  String query;
  _BottomInformation({required this.query});
  Current? current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 207,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Temperature View",
              style: textStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          gap50,
          FutureBuilder(
              future: WeatherRepoImpl().weatherInformation(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber,
                  ));
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    current = snapshot.data!.current;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${current!.temp_c}"),
                              Text("${current!.temp_f}"),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data found"),
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
