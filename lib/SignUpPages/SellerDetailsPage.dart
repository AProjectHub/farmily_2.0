import 'package:flutter/material.dart';

import '../BottomNavScreens/Profile.dart';


class SellerDetailsPage extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController taxIdNumberController = TextEditingController();
  TextEditingController paymentMethodsController = TextEditingController();

  SellerDetailsPage({
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      // Update name
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Phone Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: TextEditingController(text: phoneNumber),
                    onChanged: (value) {
                      // Update phone number
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: TextEditingController(text: address),
                    onChanged: (value) {
                      // Update address
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your address',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Business Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: businessNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your business name',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Business Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: businessTypeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your business type',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'GST Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: gstNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your GST number',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Tax Identification Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: taxIdNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your Tax ID number',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Preferred Payment Methods',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: paymentMethodsController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your preferred payment methods',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Get the entered values from text fields
                  String businessName = businessNameController.text;
                  String businessType = businessTypeController.text;
                  String gstNumber = gstNumberController.text;
                  String taxIdNumber = taxIdNumberController.text;
                  String paymentMethods = paymentMethodsController.text;
                  /*
                  // Redirect to ProfilePage and pass the filled details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        name: name,
                        phoneNumber: phoneNumber,
                        address: address,
                        businessName: businessName,
                        businessType: businessType,
                        gstNumber: gstNumber,
                        taxIdNumber: taxIdNumber,
                        paymentMethods: paymentMethods,
                      ),
                    ),
                  );

                   */
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 40.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity, // Set button width to maximum
                  child: Center(
                    child: Text('Submit'),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
