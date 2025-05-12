import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ncurideshareapp/pages/ride_confirmation_page.dart';

class OfferRidePage extends StatefulWidget {
  const OfferRidePage({super.key});

  @override
  State<OfferRidePage> createState() => _OfferRidePageState();
}

class _OfferRidePageState extends State<OfferRidePage> {
  final _formKey = GlobalKey<FormState>();
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _availableSeats = 1;
  String? _preferredRider;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  Future<void> _selectPickupLocation() async {
    // Implement logic to open a map or location picker
    // For now, a simple default is set
    // setState(() {
    //   _pickupLocation = const LatLng(12.9716, 77.5946); // Example
    // });

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
    // Implement logic to open a map or location picker
    // For now, a simple default is set
    // setState(() {
    //   _dropoffLocation = const LatLng(13.0827, 80.2707); // Example
    // });
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
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
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
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _incrementSeats() {
    setState(() {
      _availableSeats = (_availableSeats < 4) ? _availableSeats + 1 : _availableSeats;
    });
  }

  void _decrementSeats() {
    setState(() {
      _availableSeats = (_availableSeats > 1) ? _availableSeats - 1 : _availableSeats;
    });
  }

  void _offerRide() {
    if (_formKey.currentState!.validate()) {
      if (_pickupLocation == null || _dropoffLocation == null || _selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select pickup, dropoff, date, and time.')),
        );
        return;
      }
      print('Offering ride with: Pickup=$_pickupLocation, Dropoff=$_dropoffLocation, Date=$_selectedDate, Time=$_selectedTime, Seats=$_availableSeats, Preferred Rider=$_preferredRider');
      // Logic to offer the ride (e.g., API call)
      // Navigate to a confirmation or manage rides page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RideConfirmationPage(phoneNumber: '',)),
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
        title: const Text('Offer a Ride'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map View Placeholder
              Image.asset(
                'assets/images/map.png', // Replace with your image path
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
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
                subtitle: _selectedDate != null ? Text(DateFormat('EEE, MMM d, y').format(_selectedDate!)) : const Text('Tap to select'),
                onTap: () => _selectDate(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.timer, color: Colors.orange),
                title: const Text('Select Time'),
                subtitle: _selectedTime != null ? Text(_selectedTime!.format(context)) : const Text('Tap to select'),
                onTap: () => _selectTime(context),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Icon(Icons.event_seat, color: Colors.grey),
                    const SizedBox(width: 16),
                    const Text('Available Seats:', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementSeats,
                    ),
                    Text('$_availableSeats', style: const TextStyle(fontSize: 18)),
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
                    const Text('Preferred Rider:', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _preferredRider,
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
                          _preferredRider = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _offerRide,
                icon: const Icon(Icons.local_car_wash, color: Colors.white),
                label: const Text('Offer Ride', style: TextStyle(color: Colors.white, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

