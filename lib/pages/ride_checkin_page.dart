import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
// import 'package:google_maps_flutter_platform_interface/src/types/location.dart'; // Remove
import 'request_sent_page.dart'; // Import the RequestSentPage

class RideCheckInPage extends StatelessWidget {
  //  Pass data from the SearchResultsPage
  final String driverName;
  final String vehicleDetails;
  final String otp;
  // final LatLng pickupLocation;  // Remove
  // final LatLng dropoffLocation; // Remove
  final String pickupLocationName;
  final String dropoffLocationName;
  final double estimatedFare; // Added to pass to RequestSentPage
  final String paymentMethod; // Added to pass to RequestSentPage

  const RideCheckInPage({
    super.key,
    required this.driverName,
    required this.vehicleDetails,
    required this.otp,
    // required this.pickupLocation, // Removed
    // required this.dropoffLocation, // Removed
    required this.pickupLocationName,
    required this.dropoffLocationName,
    required this.estimatedFare,
    required this.paymentMethod, required LatLng pickupLocation, required LatLng dropoffLocation,
  });

  @override
  Widget build(BuildContext context) {
    //  Create a Polyline to show the route  // Remove
    // final Set<Polyline> polyline = {
    //   Polyline(
    //     polylineId: const PolylineId('route'),
    //     color: Colors.blue,
    //     points: [pickupLocation, dropoffLocation],
    //     width: 5,
    //   ),
    // };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Check-In'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Map Section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/map_placeholder.png', // Placeholder image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //  Pickup and Dropoff Location Names
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pickup Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        pickupLocationName,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Dropoff Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        dropoffLocationName,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //  Driver Info Section
              Text(
                'Driver Details:',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          driverName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driverName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            vehicleDetails,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //  OTP Section
              Text(
                'OTP for Verification:',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.yellow.shade400),
                ),
                child: Center(
                  child: Text(
                    otp,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //  Check-In Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //  Navigate to RequestSentPage and pass data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestSentPage(
                          driverName: driverName,
                          vehicleDetails: vehicleDetails,
                          pickupLocationName: pickupLocationName,
                          dropoffLocationName: dropoffLocationName,
                          estimatedFare:
                          12.50, //  Replace with actual fare calculation
                          paymentMethod:
                          'Credit Card', //  Replace with actual payment method
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CHECK IN',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

