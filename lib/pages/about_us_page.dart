import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  App Logo
              Center(
                child: Image.asset(
                  'assets/images/ncu_logo.png', //  Replace with your app's logo
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 20),
              //  App Name
              const Center(
                child: Text(
                  'NCU Carpool', //  Replace with your app's name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //  Our Mission
              const Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'To connect students and faculty at NCU for convenient, affordable, and sustainable transportation. We aim to reduce traffic congestion, lower carbon emissions, and build a stronger campus community.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              //  Our Vision
              const Text(
                'Our Vision',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'To be the leading platform for campus transportation, fostering a culture of sharing and collaboration among the NCU community.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              //  Core Values
              const Text(
                'Our Core Values',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  Community: Building a strong and connected campus.', style: TextStyle(fontSize: 16)),
                  Text('•  Sustainability: Reducing our environmental impact.', style: TextStyle(fontSize: 16)),
                  Text('•  Convenience: Making transportation easy and accessible.', style: TextStyle(fontSize: 16)),
                  Text('•  Safety: Ensuring a secure and reliable platform.', style: TextStyle(fontSize: 16)),
                  Text('•  Affordability: Providing cost-effective travel options.', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 30),
              //  Contact Us
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Email: support@ncu-carpool.com\nPhone: +91 9876543210\nAddress: NorthCap University, Sector 23-A, Gurugram, Haryana, India',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
