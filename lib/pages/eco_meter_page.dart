import 'package:flutter/material.dart';

class EcoMeterPage extends StatefulWidget {
  const EcoMeterPage({super.key});

  @override
  _EcoMeterPageState createState() => _EcoMeterPageState();
}

class _EcoMeterPageState extends State<EcoMeterPage> {
  // Dummy data for demonstration
  String userName = "Oditi";
  double co2Reduced = 0.0;
  int carpoolsShared = 0;
  double distanceShared = 0.0;
  int newFriends = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ECOMETER"),
        backgroundColor: Colors.green[700], // Consistent app bar color
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white, //white background as requested
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Consistent text color
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              "KG of CO2 Reduced",
              co2Reduced.toStringAsFixed(1), //show 1 decimal place
              "KG",
            ),
            const SizedBox(height: 15),
            _buildInfoCard(
              "Carpool Shared",
              carpoolsShared.toString(),
              "Carpool(s)",
            ),
            const SizedBox(height: 15),
            _buildInfoCard(
              "Distance Shared",
              distanceShared.toStringAsFixed(1), //show 1 decimal place
              "KM",
            ),
            const SizedBox(height: 25),
            const Text(
              "NO NEW FRIENDS YET",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey, //保持灰色
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "New friends made",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, //保持灰色
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey,), //保持灰色
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100], // Light green for the info cards
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Consistent text color
                ),
              ),
              const SizedBox(width: 5),
              Text(unit, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}

