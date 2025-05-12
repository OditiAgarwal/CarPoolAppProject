import 'package:flutter/material.dart';

class UserHistoryPage extends StatelessWidget {
  // Sample data for ride history
  final List<Map<String, String>> rideHistory = [
    {
      'date': '2024-07-28',
      'time': '10:00 AM',
      'pickup': 'North County University',
      'dropoff': 'City Center Mall',
      'fare': '\$15.00',
      'status': 'Completed',
    },
    {
      'date': '2024-07-27',
      'time': '03:30 PM',
      'pickup': 'Downtown Library',
      'dropoff': 'North County University',
      'fare': '\$12.50',
      'status': 'Completed',
    },
    {
      'date': '2024-07-26',
      'time': '08:00 AM',
      'pickup': 'Apartment Complex A',
      'dropoff': 'Office Building B',
      'fare': '\$20.00',
      'status': 'Cancelled',
    },
    {
      'date': '2024-07-25',
      'time': '06:00 PM',
      'pickup': 'North County University',
      'dropoff': 'Grocery Store C',
      'fare': '\$10.00',
      'status': 'Completed',
    },
    {
      'date': '2024-07-24',
      'time': '12:00 PM',
      'pickup': 'High School D',
      'dropoff': 'North County University',
      'fare': '\$17.50',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Ride History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: rideHistory.length,
                itemBuilder: (context, index) {
                  final ride = rideHistory[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: ${ride['date']}',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('Time: ${ride['time']}'),
                              const SizedBox(height: 8),
                              Text('Pickup: ${ride['pickup']}'),
                              Text('Dropoff: ${ride['dropoff']}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Fare: ${ride['fare']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Status: ${ride['status']}',
                                style: TextStyle(
                                  color: ride['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
