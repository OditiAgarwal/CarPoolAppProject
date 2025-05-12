import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // light green eco-friendly
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo or Animation
              Lottie.asset('assets/animations/carpool_green.json',
                  width: 200, height: 200),

              const SizedBox(height: 20),

              // App Name
              Text(
                "NCU RideShare",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),

              const SizedBox(height: 8),

              // Tagline
              Text(
                "It's cool to carpool",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[900],
                  letterSpacing: 1.1,
                ),
              ),

              const SizedBox(height: 40),

              // Loading animation
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
