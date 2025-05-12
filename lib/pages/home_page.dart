import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/offer_ride_page.dart';
import 'package:ncurideshareapp/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/location_helper.dart';
import 'chat_bot_page.dart';
import 'find_ride_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final String phoneNumber;

  const HomePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Oditi';
    });
  }

  void _showChatBot(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatBotPage()),
    );
  }

  Future<void> _handleNavigationWithLocation(
      BuildContext context, Widget destination) async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    } else if (status == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permission is required to use this feature.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (status == PermissionStatus.permanentlyDenied) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Location Permission Required"),
            content: const Text(
                "Please enable location permission in your device settings to use this feature."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text("Settings"))
            ],
          ));
    }
  }

  Widget ecoTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.eco, color: Colors.green[600]),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NCU Carpool"),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfilePage(phoneNumber: widget.phoneNumber),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/city_car.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome, $name!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                bool locationReady = await ensureLocationIsEnabled(context);
                if (locationReady) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FindRidePage()),
                  );
                }
                // Else, SnackBars inside ensureLocationIsEnabled already show messages.
              },
              icon: const Icon(Icons.search, color: Colors.white),
              label:
              const Text("Find a Ride", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size(double.infinity, 56),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                bool locationReady = await ensureLocationIsEnabled(context);
                if (locationReady) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OfferRidePage()),
                  );
                }
                // Else, SnackBars inside ensureLocationIsEnabled already show messages.
              },
              icon: const Icon(Icons.search, color: Colors.white),
              label:
              const Text("Offer A Ride", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size(double.infinity, 56),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 60),
            Divider(thickness: 1, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              "🌍 Eco-Friendly Tips",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 10),
            ecoTip("✔️ Share rides to reduce carbon emissions."),
            ecoTip("✔️ Prefer electric or hybrid vehicles."),
            ecoTip("✔️ Walk or cycle for short distances."),
            const SizedBox(height: 40),
            Divider(thickness: 1, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              "🎯 Green Points Program",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "✅ Earn Green Points each time you book/offer a ride!\n"
                  "✅ Redeem points at the NCU Canteen!\n"
                  "✅ Top scorers featured on the Green Leaderboard!",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showChatBot(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat),
      ),
    );
  }
}

