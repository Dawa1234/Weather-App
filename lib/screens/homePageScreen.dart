import 'package:flutter/material.dart';
import 'package:weather_app/dataSource/weatherDataSource.dart';
import 'package:weather_app/measures.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WeatherDataSource().weatherInformation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context)
              .unfocus(), // to unfocus keyboard when clicked anywhere outside
          child: SizedBox(
            height: fullHeight(context),
            width: fullWidth(context),
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage("assets/images/border.png"))),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Container(
                      color: Colors.amber,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  suffixIcon: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 90,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: MaterialButton(
                                            height: 30,
                                            textColor: const Color.fromARGB(
                                                255, 80, 80, 80),
                                            onPressed: () {},
                                            color: const Color.fromARGB(
                                                255, 218, 218, 218),
                                            child: const Text("Save")),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 1)),
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Cloudy",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "Verkhoyansk, Rusia",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: "-12",
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    TextSpan(
                                        text: "°",
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ))
                ]),
          ),
        ),
      ),
    );
  }
}
