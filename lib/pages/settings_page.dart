import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_password_page.dart';
import 'manage_account_page.dart';

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
              title: const Text('Delete Account'),
              onTap: () {
                // Navigate to manage account page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageAccountPage(),
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
