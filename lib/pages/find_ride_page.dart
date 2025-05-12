import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'search_results_page.dart'; // Import the SearchResultsPage

class FindRidePage extends StatefulWidget {
  const FindRidePage({super.key});

  @override
  State<FindRidePage> createState() => _FindRidePageState();
}

class _FindRidePageState extends State<FindRidePage> {
  final _formKey = GlobalKey<FormState>();
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _seats = 1;
  String? _preferredDriver;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  Future<void> _selectPickupLocation() async {
    // 1. Show Dialog
    String? location = await showDialog<String>(
      context: context,
      builder: (context) => const LocationInputDialog(title: "Pickup Location"),
    );
    // 2.  Update State
    if (location != null && location.isNotEmpty) {
      setState(() {
        _pickupController.text = location;
        _pickupLocation =
        const LatLng(12.9716, 77.5946); // Retain default logic for now.
      });
    }
  }

  Future<void> _selectDropoffLocation() async {
    String? location = await showDialog<String>(
      context: context,
      builder: (context) => const LocationInputDialog(title: "Dropoff Location"),
    );
    if (location != null && location.isNotEmpty) {
      setState(() {
        _dropoffController.text = location;
        _dropoffLocation =
        const LatLng(13.0827, 80.2707); // Retain default logic for now.
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      _selectedDate ?? DateTime.now(), // Use _selectedDate if already picked
      firstDate: DateTime.now(), // Correctly pass DateTime object
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;

      });
    }
  }

  void _incrementSeats() {
    setState(() {
      _seats = (_seats < 4) ? _seats + 1 : _seats;
    });
  }

  void _decrementSeats() {
    setState(() {
      _seats = (_seats > 1) ? _seats - 1 : _seats;
    });
  }

  void _findPool() {
    if (_formKey.currentState!.validate()) {
      if (_pickupLocation == null ||
          _dropoffLocation == null ||
          _selectedDate == null ||
          _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Please select pickup, dropoff, date, and time.')),
        );
        return;
      }
      print(
          'Finding pool with: Pickup=$_pickupLocation, Dropoff=$_dropoffLocation, Date=$_selectedDate, Time=$_selectedTime, Seats=$_seats, Preferred Driver=$_preferredDriver');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage( // Pass the data
            pickupLocation: _pickupLocation!,
            dropoffLocation: _dropoffLocation!,
            selectedDateTime: DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            ),
            seats: _seats,
            preferredDriver: _preferredDriver,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Ride'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use an Image widget here
              Image.asset(
                'assets/images/map.png', // Replace with your image path
                height: 150, // Reduced height for better layout
                width: double.infinity,
                fit: BoxFit.cover, // Ensure the image covers the container
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.green),
                title: const Text('Select Pickup Location'),
                subtitle: _pickupController.text.isNotEmpty
                    ? Text(_pickupController.text)
                    : const Text('Tap to select'),
                onTap: _selectPickupLocation,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.flag, color: Colors.redAccent),
                title: const Text('Select Dropoff Location'),
                subtitle: _dropoffController.text.isNotEmpty
                    ? Text(_dropoffController.text)
                    : const Text('Tap to select'),
                onTap: _selectDropoffLocation,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: const Text('Select Date'),
                subtitle: _selectedDate != null
                    ? Text(DateFormat('EEE, MMM d, y').format(_selectedDate!))
                    : const Text('Tap to select'),
                onTap: () => _selectDate(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.timer, color: Colors.orange),
                title: const Text('Select Time'),
                subtitle: _selectedTime != null
                    ? Text(_selectedTime!.format(context))
                    : const Text('Tap to select'),
                onTap: () => _selectTime(context),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.grey),
                    const SizedBox(width: 16),
                    const Text('Seats:', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementSeats,
                    ),
                    Text('$_seats', style: const TextStyle(fontSize: 18)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementSeats,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Icon(Icons.face, color: Colors.blueGrey),
                    const SizedBox(width: 16),
                    const Text('Preferred Driver:',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _preferredDriver,
                      hint: const Text('Any'),
                      items: <String>['Any', 'Female', 'Male']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _preferredDriver = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _findPool,
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text('Find Pool',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Custom Dialog
class LocationInputDialog extends StatefulWidget {
  final String title;
  const LocationInputDialog({super.key, required this.title});

  @override
  _LocationInputDialogState createState() => _LocationInputDialogState();
}

class _LocationInputDialogState extends State<LocationInputDialog> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _locationController,
        decoration: const InputDecoration(hintText: 'Enter location'),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          Navigator.pop(context, _locationController.text);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _locationController.text);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

