import 'package:flutter/material.dart';

class CustomerDetailsPage extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;

  CustomerDetailsPage({
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: name),
              onChanged: (value) {
                // Update name
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: TextEditingController(text: phoneNumber),
              onChanged: (value) {
                // Update phone number
              },
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: TextEditingController(text: address),
              onChanged: (value) {
                // Update address
              },
              decoration: InputDecoration(labelText: 'Address'),
            ),
            // Add additional fields for customer-specific details
          ],
        ),
      ),
    );
  }
}
