import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/profile_success_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final promoCodeController = TextEditingController();
  String gender = "Male";

  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {

      return 'Invalid email format';
    }
    if (!value.endsWith("@ncuindia.edu")) {
      return 'Only @ncuindia.edu emails are allowed';
    }
    return null;
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '\$fieldName is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildGenderSelector() {
    final genders = [
      "Male",
      "Female",
      "Non-Binary",
      "Prefer not to say",
      "Other"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: genders.map((g) {
            return ChoiceChip(
              label: Text(g),
              selected: gender == g,
              onSelected: (_) => setState(() => gender = g),
              selectedColor: Colors.green[100],
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: gender == g ? Colors.green[800] : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setString('email', emailController.text);
      await prefs.setString('gender', gender);
      await prefs.setString('promoCode', promoCodeController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileSuccessPage()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Set Up Your Profile"),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to NCU Carpool!",
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Let’s complete your profile to match better rides.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 24),
                _buildTextField(
                  controller: nameController,
                  label: "Full Name",
                  icon: Icons.person,
                  validator: (value) =>
                      _validateField(value, "Full Name"),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: emailController,
                  label: "Email Address",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                SizedBox(height: 16),
                _buildGenderSelector(),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Enter Promo/Referral Code",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: promoCodeController,
                              label: "Promo Code",
                              icon: Icons.percent,
                              validator: (value) => null,
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Apply"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.local_offer_rounded,
                          color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text("Have a promo/referral code?",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitProfile,
                  child: Text("Complete Profile"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    promoCodeController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:ncurideshareapp/pages/profile_success_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http; // Import the http package
// import 'dart:convert'; // Import the dart:convert package for JSON handling
//
// class ProfileSetupPage extends StatefulWidget {
//   const ProfileSetupPage({super.key});
//
//   @override
//   _ProfileSetupPageState createState() => _ProfileSetupPageState();
// }
//
// class _ProfileSetupPageState extends State<ProfileSetupPage> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final promoCodeController = TextEditingController();
//   String gender = "Male";
//
//   final _formKey = GlobalKey<FormState>();
//
//   // Validation functions remain the same
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//       return 'Invalid email format';
//     }
//     if (!value.endsWith("@ncuindia.edu")) {
//       return 'Only @ncuindia.edu emails are allowed';
//     }
//     return null;
//   }
//
//   String? _validateField(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '\$fieldName is required';
//     }
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters long';
//     }
//     return null;
//   }
//
//   // Widget building methods remain the same
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     String? hintText,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//     bool obscureText = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         labelText: label,
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   Widget _buildGenderSelector() {
//     final genders = [
//       "Male",
//       "Female",
//       "Non-Binary",
//       "Prefer not to say",
//       "Other"
//     ];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Gender", style: TextStyle(fontWeight: FontWeight.w600)),
//         SizedBox(height: 10),
//         Wrap(
//           spacing: 8,
//           runSpacing: 4,
//           children: genders.map((g) {
//             return ChoiceChip(
//               label: Text(g),
//               selected: gender == g,
//               onSelected: (_) => setState(() => gender = g),
//               selectedColor: Colors.green[100],
//               backgroundColor: Colors.grey[200],
//               labelStyle: TextStyle(
//                 color: gender == g ? Colors.green[800] : Colors.black,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   // Function to send data to the backend
//   Future<void> _saveProfileData() async {
//     final url =
//     Uri.parse('https://your-backend-api.com/api/register'); // Replace with your API endpoint
//     final Map<String, String> data = {
//       'name': nameController.text,
//       'email': emailController.text,
//       'password': passwordController.text, // DO NOT SEND PASSWORD IN PLAIN TEXT IN A REAL APP
//       'gender': gender,
//       'promoCode': promoCodeController.text,
//     };
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(data),
//       );
//
//       if (response.statusCode == 201) {
//         // 201 Created - success.  Parse the response if needed.
//         final responseData = jsonDecode(response.body);
//         print('Success: $responseData'); //  log the response
//         // Optionally, save a token or user ID from the response.
//         // Example (if your API returns a token):
//         // final token = responseData['token'];
//         // await prefs.setString('token', token);
//
//         // Store data in shared preferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('name', nameController.text);
//         await prefs.setString('email', emailController.text);
//         await prefs.setString('gender', gender);
//         await prefs.setString('promoCode', promoCodeController.text);
//
//         // Navigate to the success page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const ProfileSuccessPage()),
//         );
//       } else {
//         // Handle errors.  Show a message to the user.
//         print('Error: ${response.statusCode}, ${response.body}');
//         _showErrorDialog('Failed to save profile.  Status Code: ${response.statusCode}');
//       }
//     } catch (error) {
//       // Handle network errors, server errors, etc.
//       print('Error: $error');
//       _showErrorDialog('Error connecting to server: $error');
//     }
//   }
//
//   // Function to show an error dialog
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _submitProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Call the function to save data to the backend
//       await _saveProfileData();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Set Up Your Profile"),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Welcome to NCU Carpool!",
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 Text("Let’s complete your profile to match better rides.",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                 const SizedBox(height: 24),
//                 _buildTextField(
//                   controller: nameController,
//                   label: "Full Name",
//                   icon: Icons.person,
//                   validator: (value) =>
//                       _validateField(value, "Full Name"),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   controller: emailController,
//                   label: "Email Address",
//                   icon: Icons.email,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: _validateEmail,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   controller: passwordController,
//                   label: "Password",
//                   icon: Icons.lock,
//                   obscureText: true,
//                   validator: _validatePassword,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildGenderSelector(),
//                 const SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (context) => Padding(
//                         padding: const EdgeInsets.all(24.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text("Enter Promo/Referral Code",
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600)),
//                             const SizedBox(height: 16),
//                             _buildTextField(
//                               controller: promoCodeController,
//                               label: "Promo Code",
//                               icon: Icons.percent,
//                               validator: (value) => null,
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text("Apply"),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green[700]),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(Icons.local_offer_rounded,
//                           color: Colors.blueAccent),
//                       const SizedBox(width: 8),
//                       Text("Have a promo/referral code?",
//                           style: const TextStyle(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 ElevatedButton(
//                   onPressed: _submitProfile,
//                   child: const Text("Complete Profile"),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 48),
//                     backgroundColor: Colors.green[700],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     promoCodeController.dispose();
//     super.dispose();
//   }
// }
//
