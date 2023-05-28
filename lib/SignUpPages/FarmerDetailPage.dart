import 'package:flutter/material.dart';

import '../Screens/Homescreen.dart';

class FarmerDetailsPage extends StatefulWidget {
  late final String name;
  late final String phoneNumber;
  late final String address;
  late final String acresOfLand;
  late final String yieldType;
  late final String rationCardNumber;

  FarmerDetailsPage({
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.acresOfLand = '',
    this.yieldType = '',
    this.rationCardNumber = '',
  });

  @override
  _FarmerDetailsPageState createState() => _FarmerDetailsPageState();
}

class _FarmerDetailsPageState extends State<FarmerDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController acresOfLandController = TextEditingController();
  TextEditingController yieldTypeController = TextEditingController();
  TextEditingController rationCardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    phoneNumberController.text = widget.phoneNumber;
    addressController.text = widget.address;
    acresOfLandController.text = widget.acresOfLand;
    yieldTypeController.text = widget.yieldType;
    rationCardNumberController.text = widget.rationCardNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {
                      widget.name = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: phoneNumberController,
                  onChanged: (value) {
                    setState(() {
                      widget.phoneNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Phone Number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: addressController,
                  onChanged: (value) {
                    setState(() {
                      widget.address = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Acres of Land',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: acresOfLandController,
                  onChanged: (value) {
                    setState(() {
                      widget.acresOfLand = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Acres of Land',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Yield Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: yieldTypeController,
                  onChanged: (value) {
                    setState(() {
                      widget.yieldType = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Yield Type',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Ration Card Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: rationCardNumberController,
                  onChanged: (value) {
                    setState(() {
                      widget.rationCardNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Ration Card Number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Perform further actions or processing

                    // Redirect to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontFamily: 'Roboto'),
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
