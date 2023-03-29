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
    Future.delayed(const Duration(seconds: 5)).then(
        (value) => Navigator.of(context).pushReplacementNamed("/homeScreen"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // background image
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
              // top heading
              SizedBox(
                height: 100,
                width: fullWidth(context) * 0.8,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                        text: "We Show Weather For You",
                        style: TextStyle(
                            fontSize: 29,
                            fontFamily: "Capriola",
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 35, 162, 150)),
                      )
                    ])),
              ),
              gap10,
              // weather image
              SizedBox(
                height: 220,
                width: 300,
                child: Column(
                  children: [
                    // image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 0, 61, 136),
                                spreadRadius: 2,
                                blurRadius: 10)
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/app-icon.jpg"),
                          )),
                    ),
                    gap10,

                    // image name
                    const Text(
                      "Weather App",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Capriola",
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 116, 245)),
                    ),
                    gap10,
                    const Text(
                      "We Show weather for you.",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Capriola",
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 177, 177, 177)),
                    )
                  ],
                ),
              ),
              gap30,
              // Skip button
              SizedBox(
                width: fullWidth(context) * 0.8,
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed("/homeScreen"),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 47, 154, 156))),
                    child: const Text(
                      "Skip >>",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
