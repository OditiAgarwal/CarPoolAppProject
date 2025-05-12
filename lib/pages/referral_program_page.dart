import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferralProgramPage extends StatelessWidget {
  final String userReferralCode = "NCU1234"; // Replace with actual user code

  void _shareReferral(BuildContext context) {
    final shareText =
        "Join NCU Rideshare and get free rides! Use my referral code $userReferralCode to sign up. 🚗🌱";
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral Program"),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Invite Friends & Earn Rewards",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Your Referral Code:",
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userReferralCode,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.green),
                    onPressed: () => _shareReferral(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text("Enter a Referral Code",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter friend's code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: validate and apply referral code
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Apply Code"),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                // Navigate to terms page if needed
              },
              child: Text("View Referral Terms & Conditions"),
            )
          ],
        ),
      ),
    );
  }
}
