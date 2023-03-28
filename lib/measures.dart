import 'package:flutter/material.dart';

// Phone Measures
double fullHeight(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  return height;
}

double fullWidth(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return width;
}

// Gaps
SizedBox gap10 = const SizedBox(height: 10);
SizedBox gap30 = const SizedBox(height: 30);
SizedBox gap50 = const SizedBox(height: 50);
