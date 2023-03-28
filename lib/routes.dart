import 'package:flutter/material.dart';
import 'package:weather_app/screens/homePageScreen.dart';

import 'screens/helpScreen.dart';

// Routes
var getRoutes = <String, WidgetBuilder>{
  "/helpScreen": (context) => const HelpScreen(),
  "/homeScreen": (context) =>  HomePageScreen(),
};
