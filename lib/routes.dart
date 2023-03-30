import 'package:flutter/material.dart';
import 'package:weather_app/screens/homePageScreen.dart';

import 'screens/helpScreen.dart';

// Routes
var getRoutes = <String, WidgetBuilder>{
  HelpScreen.route: (context) => const HelpScreen(),
  HomePageScreen.route: (context) => const HomePageScreen(),
};
