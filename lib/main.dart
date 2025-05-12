import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/home_page.dart';
// import 'package:ncurideshareapp/pages/otp_verification_page.dart';
import 'package:ncurideshareapp/pages/profile_setup_page.dart';

import 'pages/phone_input_page.dart';
import 'screens/onboarding_screen.dart';
import 'screens/theme.dart';

import 'pages/offer_ride_page.dart';

void main() {
  runApp(const MyCarpoolApp());
}

class MyCarpoolApp extends StatelessWidget {
  const MyCarpoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCU Carpool',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: GlobalKey<NavigatorState>(), // Add a navigatorKey
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => const HomePage(phoneNumber: ''),
      },
    );
  }
}

