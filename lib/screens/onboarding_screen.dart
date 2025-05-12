// import 'package:flutter/material.dart';
// import '../pages/phone_input_page.dart';
//
//
// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const SizedBox(height: 30),
//
//           // Logo and App Name
//           Column(
//             children: [
//               Image.asset('assets/images/ncu_logo.png', height: 100),
//               const SizedBox(height: 10),
//               const Text(
//                 'NCU Ride',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//               const Text(
//                 'Carpool • Bikepool • Verified Rides',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//
//           // Carpool Option
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.group, size: 30, color: Colors.green),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("Carpool",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           Text("Eco-friendly rides with fellow NCU students"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Bikepool Option
//                 Row(
//                   children: [
//                     const Icon(Icons.pedal_bike, size: 30, color: Colors.green),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("Bikepool",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           Text("Quick, economical rides across campus"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // Enter phone number or NCU ID
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => PhoneInputPage()),
//                 );
//               },
//
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[600],
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 minimumSize: const Size.fromHeight(55),
//               ),
//               child: const Text("Enter your NCU ID / Phone Number", style: TextStyle(fontSize: 18)),
//             ),
//           ),
//
//           // Terms
//           const Padding(
//             padding: EdgeInsets.only(bottom: 20),
//             child: Text.rich(
//               TextSpan(
//                 text: "By continuing, you agree to NCU Ride ",
//                 children: [
//                   TextSpan(
//                     text: "Terms",
//                     style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               style: TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/phone_input_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to NCU Carpool",
      "subtitle": "Eco-friendly. Safe. Smart.",
      "image": "assets/images/onboard1.png"
    },
    {
      "title": "Find or Offer Rides",
      "subtitle": "Connect with trusted NCU students.",
      "image": "assets/images/onboard2.png"
    },
    {
      "title": "Start Carpooling Today",
      "subtitle": "Let’s reduce traffic and pollution together.",
      "image": "assets/images/onboard3.png"
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PhoneInputPage()),
      );
    }
  }

  Widget _buildPage(Map<String, String> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(data["image"]!, height: 280),
        SizedBox(height: 32),
        Text(
          data["title"]!,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Text(
          data["subtitle"]!,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: _buildPage(onboardingData[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentPage == onboardingData.length - 1 ? "Get Started" : "Next"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneInputPage()),
                    );
                  },
                  child: Text("Skip", style: TextStyle(color: Colors.grey[600])),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
