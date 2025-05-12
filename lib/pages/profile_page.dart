import 'package:flutter/material.dart';
import 'package:ncurideshareapp/pages/about_us_page.dart';
import 'package:ncurideshareapp/pages/referral_program_page.dart';
import 'package:ncurideshareapp/pages/user_history_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';
import 'package:ncurideshareapp/pages/phone_input_page.dart'; // Import your phone input page
import 'eco_meter_page.dart'; // Import the EcoMeterPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String phoneNumber});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDriver = false;
  String name = '';
  String email = '';
  String contact = '';
  int ridesCompleted = 0;
  String? licenseNumber;
  double averageRating = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for the Scaffold

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDriver = prefs.getString('userType') == 'driver';
      name = prefs.getString('name') ?? 'Latika Mukhi';
      email = prefs.getString('email') ?? 'latika@ncuindia.edu';
      contact = prefs.getString('contact') ?? '+91-8178596827';
      ridesCompleted = prefs.getInt('ridesCompleted') ?? 0;
      licenseNumber = prefs.getString('licenseNumber');
      averageRating = prefs.getDouble('averageRating') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          // Three-dot menu button
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Text(contact, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Passenger"),
                    selected: !isDriver,
                    selectedColor: Colors.green[300],
                    onSelected: (selected) {
                      _updateUserType(false);
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("Driver"),
                    selected: isDriver,
                    selectedColor: Colors.green[300],
                    onSelected: (selected) {
                      _updateUserType(true);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              isDriver ? _buildDriverMode() : _buildPassengerMode(),
              const SizedBox(height: 20),
              Divider(thickness: 1.2, color: Colors.green[300]),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: name,
                        email: email,
                        contact: contact,
                        isDriver: isDriver,
                      ),
                    ),
                  );

                  if (updatedData != null) {
                    setState(() {
                      name = updatedData['name'];
                      email = updatedData['email'];
                      contact = updatedData['contact'];
                      isDriver = updatedData['isDriver'];
                    });
                    _saveProfileData(); // Save updated data
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneInputPage()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: _buildDrawer(), // Set the endDrawer
    );
  }

  Future<void> _updateUserType(bool isDriver) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', isDriver ? 'driver' : 'passenger');
    setState(() {
      this.isDriver = isDriver;
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('contact', contact);
    await prefs.setString('userType', isDriver ? 'driver' : 'passenger');
    await prefs.setInt('ridesCompleted', ridesCompleted);
    await prefs.setString('licenseNumber', licenseNumber ?? '');
    await prefs.setDouble('averageRating', averageRating);
  }

  Widget _buildDriverMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🚗 Driver Stats",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        _infoRow("⭐ Rating", "${averageRating.toStringAsFixed(1)} / 5"),
        _infoRow("Trips Offered", "$ridesCompleted"),
        _infoRow("Vehicle", "Honda City | DL01AB1234"), // Hardcoded, should be dynamic
        if (licenseNumber != null)
          _infoRow("License No", licenseNumber!),
        const SizedBox(height: 20),
        const Text(
          "💬 Passenger Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        _comment("Great and safe driver!", "Riya"), // Hardcoded
        _comment("On time and polite.", "Arjun"), // Hardcoded
      ],
    );
  }

  Widget _buildPassengerMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🚕 Passenger Stats",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        _infoRow("Rides Taken", "$ridesCompleted"),
        _infoRow("Total Distance", "180 km"), // Hardcoded
        const SizedBox(height: 20),
        const Text(
          "💬 Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        _comment("She was kind.", "From: Simran"), // Hardcoded
        _comment("Good music taste!", "From: Raghav"), // Hardcoded
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Widget _comment(String text, String from) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: const Icon(Icons.comment, size: 20, color: Colors.indigo),
        title: Text(text),
        subtitle: Text(from),
        tileColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[700],
            ),
            child: const Text(
              'Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Ecometer'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EcoMeterPage()),
              );
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserHistoryPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Refer Page'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReferralProgramPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Default values
  bool _notificationsEnabled = true;
  String _mapProvider = 'Google Maps';
  String _theme = 'Light';
  final List<String> _mapOptions = ['Google Maps', 'OpenStreetMap'];
  final List<String> _themeOptions = ['Light', 'Dark', 'System'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled =
          prefs.getBool('notificationsEnabled') ?? true; // Default is true
      _mapProvider =
          prefs.getString('mapProvider') ?? 'Google Maps'; // Default is Google Maps
      _theme = prefs.getString('theme') ?? 'Light'; // Default is Light
    });
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setString('mapProvider', _mapProvider);
    await prefs.setString('theme', _theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildHeader('General Settings'),
            _buildSwitchTile(
              'Enable Notifications',
              _notificationsEnabled,
                  (value) {
                setState(() {
                  _notificationsEnabled = value;
                  _saveSettings();
                });
              },
            ),
            _buildDropdownTile(
              'Map Provider',
              _mapProvider,
              _mapOptions,
                  (value) {
                setState(() {
                  _mapProvider = value!;
                  _saveSettings();
                });
              },
            ),
            _buildDropdownTile(
              'Theme',
              _theme,
              _themeOptions,
                  (value) {
                setState(() {
                  _theme = value!;
                  _saveSettings();
                });
              },
            ),
            const SizedBox(height: 20),
            _buildHeader('Account'),
            ListTile(
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to change password page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Manage Account'),
              onTap: () {
                // Navigate to manage account page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageAccountPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                // Navigate to manage account page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
      String title, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }

  Widget _buildDropdownTile(String title, String value, List<String> options,
      void Function(String?)? onChanged) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }
}

// Placeholder pages for Change Password and Manage Account
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Change Password Page'),
      ),
    );
  }
}

class ManageAccountPage extends StatelessWidget {
  const ManageAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Account'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Manage Account Page'),
      ),
    );
  }
}

