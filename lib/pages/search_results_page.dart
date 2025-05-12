import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ncurideshareapp/pages/ride_checkin_page.dart'; // Import the RideCheckInPage

class SearchResultsPage extends StatelessWidget {
  final LatLng pickupLocation;
  final LatLng dropoffLocation;
  final DateTime selectedDateTime;
  final int seats;
  final String? preferredDriver;

  const SearchResultsPage({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.selectedDateTime,
    required this.seats,
    this.preferredDriver,
  });

  // Dummy data for demonstration.  In a real app, this would come from a server.
  //  The data is now a function of the search criteria.
  List<Map<String, dynamic>> _generateMatches() {
    //  Use the passed-in parameters to filter the results.
    //  For demonstration, we'll just create some dummy data that's
    //  related to the user's search.

    //  1.  Calculate a time range (e.g., +/- 30 minutes)
    final startTime = selectedDateTime.subtract(const Duration(minutes: 30));
    final endTime = selectedDateTime.add(const Duration(minutes: 30));

    // 2.  Create some dummy drivers with varying preferences and times
    final List<Map<String, dynamic>> allDrivers = [
      {
        'name': 'George Wallace',
        'type': 'Student',
        'endorsements': 'Endorsed by 1 rider',
        'rating': 4.7,
        'ratingCount': 69,
        'time': startTime.add(const Duration(minutes: 15)).toIso8601String(),
        'distance': '502 m > 130 m',
        'points': 50,
        'matchPercentage': 'Full Match',
        'driverPreference': 'Any',
        'vehicleDetails': 'DL9C AB 6297 Red Swift Maruti Suzuki', // Add Vehicle details
        'estimatedFare': 15.00,  // Added
        'paymentMethod': 'Credit Card', // Added
        'pickupLocationName': 'Pickup Location A', //added
        'dropoffLocationName': 'Dropoff Location B' //added
      },
      {
        'name': 'Gokul Rath',
        'type': 'Teacher',
        'endorsements': 'Endorsed by 1 rider',
        'rating': 5.0,
        'ratingCount': 156,
        'time': endTime.subtract(const Duration(minutes: 10)).toIso8601String(),
        'distance': '502 m > 130 m',
        'points': 50,
        'matchPercentage': '97% Route Match',
        'driverPreference': 'Any',
        'vehicleDetails': 'KA 01 XX 1234 Silver Honda City', // Add Vehicle details
        'estimatedFare': 20.00, // Added
        'paymentMethod': 'UPI', // Added
        'pickupLocationName': 'Pickup Location C', //added
        'dropoffLocationName': 'Dropoff Location D' //added
      },
      {
        'name': 'Shreya Kumar',
        'type': 'Student',
        'endorsements': 'Capgemini',
        'rating': 4.2,
        'ratingCount': 54,
        'time': selectedDateTime.toIso8601String(),
        'distance': '502 m > 130 m',
        'points': 50,
        'matchPercentage': '96% Route Match',
        'driverPreference': 'Female',
        'vehicleDetails': 'TN 07 XY 5678 Black Hyundai i20', // Add Vehicle details
        'estimatedFare': 18.00, // Added
        'paymentMethod': 'Wallet', // Added
        'pickupLocationName': 'Pickup Location E', //added
        'dropoffLocationName': 'Dropoff Location F' //added
      },
      {
        'name': 'Alice Smith',
        'type': 'Teacher',
        'endorsements': 'Google',
        'rating': 4.9,
        'ratingCount': 200,
        'time': startTime.toIso8601String(),
        'distance': '600 m > 200 m',
        'points': 60,
        'matchPercentage': '98% Route Match',
        'driverPreference': 'Female',
        'vehicleDetails': 'AP 09 AZ 9012 White Toyota Innova', // Add Vehicle details
        'estimatedFare': 22.00, // Added
        'paymentMethod': 'Credit Card', // Added
        'pickupLocationName': 'Pickup Location G', //added
        'dropoffLocationName': 'Dropoff Location H' //added
      },
    ];

    // 3. Filter the drivers based on the user's preferences.
    List<Map<String, dynamic>> filteredDrivers = allDrivers.where((driver) {
      //  Time within range
      final driverTime = DateTime.parse(driver['time']);
      final timeInRange =
          driverTime.isAfter(startTime) && driverTime.isBefore(endTime);

      //  Driver preference
      final preferenceMatches = preferredDriver == null ||
          preferredDriver == 'Any' ||
          driver['driverPreference'] == driver['driverPreference'];

      return timeInRange && preferenceMatches;
    }).toList();

    // 4.  Sort the drivers by time (closest first)
    filteredDrivers.sort((a, b) {
      final timeA = DateTime.parse(a['time']).millisecondsSinceEpoch;
      final timeB = DateTime.parse(b['time']).millisecondsSinceEpoch;
      return timeA.compareTo(timeB);
    });

    return filteredDrivers;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> matches = _generateMatches();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Matches'),
        backgroundColor: Colors.green[700],
      ),
      body: matches.isNotEmpty
          ? ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          final driverTime = DateTime.parse(match['time']);
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Replace CircleAvatar with a Text widget
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300], // Light grey background
                        ),
                        child: Text(
                          match['name'][0].toUpperCase(), // First letter
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Dark text color
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              match['name'] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              match['type'] as String,
                              // Display "Student" or "Teacher"
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              match['endorsements'] as String,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${match['rating']} (${match['ratingCount']})',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          match['matchPercentage'] as String,
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  DateFormat('h:mm a').format(driverTime),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ), // Format
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.directions,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${match['distance']} away',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.monetization_on,
                                  color: Colors.green, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${match['points']} Points',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (match['driverPreference'] != 'Any')
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Icon(
                                match['driverPreference'] == 'Female'
                                    ? Icons.woman
                                    : Icons.man,
                                color: Colors.blue,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Pref: ${match['driverPreference']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        //  Navigate to RideCheckInPage and pass data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RideCheckInPage(
                              driverName: match['name'],
                              vehicleDetails: match['vehicleDetails'],
                              otp: '8761', //  Replace with actual OTP generation
                              pickupLocation: pickupLocation,
                              dropoffLocation: dropoffLocation,
                              pickupLocationName: match['pickupLocationName'],
                              dropoffLocationName: match['dropoffLocationName'],
                              estimatedFare: match['estimatedFare'],  // Pass
                              paymentMethod: match['paymentMethod'], // Pass
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8.0)),
                      ),
                      child: const Text('CHECK'), // Changed text here
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text("No matching rides found."),
      ),
    );
  }
}

