import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(spreadRadius: 1, blurRadius: 3, color: Colors.blue)
        ],
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: const [
          Text("Data"),
        ],
      ),
    );
  }
}
