import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.contact,
    this.isDriver, // Make isDriver nullable
  });

  final String name;
  final String email;
  final String contact;
  final bool? isDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: TextEditingController(text: name),
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: TextEditingController(text: email),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: TextEditingController(text: contact),
              decoration: const InputDecoration(labelText: 'Contact'),
            ),
            // Use a SwitchListTile to edit the boolean value.
            SwitchListTile(
              title: const Text('Driver'),
              value: isDriver ?? false, // Provide a default value (false in this case)
              onChanged: (bool newValue) {
                //  Implement the logic to update the driver status
                //  You'll likely need a StatefulWidget for this.
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to save the edited profile data
                Navigator.of(context).pop(); // Just go back for now
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

