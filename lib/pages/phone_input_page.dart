import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/profile_setup_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;  // Import the http package
import 'dart:convert';  // Import the convert package for JSON

class PhoneInputPage extends StatefulWidget {
  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  bool isPhoneNumberVerified = false;
  //String _otpCode = "123456";  // Remove this, OTP comes from backend
  String _verificationId = ""; // To store verification ID from backend
  final String _baseUrl = "http://10.0.2.2:3000"; // Replace with your backend URL

  @override
  void initState() {
    super.initState();
  }

  // Modified sendPhoneNumber function
  Future<void> sendPhoneNumber() async {
    final phone = phoneController.text.trim();

    if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 10-digit phone number."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse('$_baseUrl/send-otp'); //  Endpoint to send OTP
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}), // Send phone number in JSON
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        //  Extract verification ID from response
        _verificationId = responseData['verificationId'];
        setState(() {
          isLoading = false;
          isPhoneNumberVerified = true; // Show OTP input field
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle error cases (e.g., phone number already registered)
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to send OTP: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle network errors or exceptions
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Modified verifyOtp function
  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the OTP."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final url = Uri.parse('$_baseUrl/verify-otp');  //  Endpoint to verify OTP
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'verificationId': _verificationId, //  Send verification ID
          'otp': otp,
          'phone': phoneController.text.trim()
        }), // Send OTP and phone number
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          setState(() {
            isLoading = false;
            isPhoneNumberVerified = true; //  You might not need this here
          });
          showDialog(
            // Show dialog
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Phone Number Verified'),
              content:
              const Text('Your phone number has been successfully verified.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushReplacement( // Navigate to the new page
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSetupPage()),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Incorrect OTP. Please try again.  ${responseData['message']}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to verify OTP: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/ncu_logo.png', height: 120),
                const SizedBox(height: 24),
                const Text(
                  "Let's Carpool Smart",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your phone number to continue",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isPhoneNumberVerified) ...[
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      prefixIcon: const Icon(Icons.security),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: verifyOtp,
                    child: isLoading
                        ? const CircularProgressIndicator(
                        color: Colors.white)
                        : const Text("Verify OTP"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.green[700],
                    ),
                  ),
                ] else
                  ElevatedButton(
                    onPressed: sendPhoneNumber,
                    child: isLoading
                        ? const CircularProgressIndicator(
                        color: Colors.white)
                        : const Text("Send OTP"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.green[700],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

