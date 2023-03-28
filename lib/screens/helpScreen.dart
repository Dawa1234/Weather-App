import 'package:flutter/material.dart';
import 'package:weather_app/measures.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5)).then(
    //     (value) => Navigator.of(context).pushReplacementNamed("/homeScreen"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: fullHeight(context),
        width: fullWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/border.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: fullWidth(context) * 0.8,
              child: const Text(
                "WE SHOW WEATHER FOR YOU",
                style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 52, 145, 166)),
              ),
            ),
            gap10,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/weather.png"),
              )),
              height: 250,
              width: fullWidth(context),
            ),
            gap30,
            SizedBox(
              width: fullWidth(context) * 0.8,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/homeScreen"),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 47, 154, 156))),
                  // icon: const Icon(Icons.skip_next),
                  child: const Text(
                    "Skip >>",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
