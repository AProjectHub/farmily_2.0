import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import '../BottomNavScreens/Profile.dart';
import '../Screens/CustomerHomePage.dart';
import '../Screens/Homescreen.dart';
import 'FarmerDetailPage.dart';
import 'SellerDetailsPage.dart';

import 'package:farmily/globals.dart'; // Import the globals file

class SignUpPage extends StatefulWidget {
  static const String screenId = 'signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedRole = 'Farmer';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Create account - it\'s free',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16.0,
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
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 16.0,
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
                      decoration: InputDecoration(
                        hintText: 'Enter your Phone Number',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16.0,
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
                      decoration: InputDecoration(
                        hintText: 'Enter your Address',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Type of Service',
                      style: TextStyle(
                        fontSize: 16.0,
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
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: Text('Select Role'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Farmer',
                          child: Text('Farmer'),
                        ),
                        DropdownMenuItem(
                          value: 'Seller',
                          child: Text('Seller'),
                        ),
                        DropdownMenuItem(
                          value: 'Customer',
                          child: Text('Customer'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity, // Make button wider
                child: ElevatedButton(
                  onPressed: () {
                    final roleProvider =
                    Provider.of<RoleProvider>(context, listen: false);
                    roleProvider.setSelectedRole(selectedRole);

                    if (selectedRole == 'Farmer') {
                      DatabaseReference newRef = databaseReference.child('user').push();
                      newRef.set({
                        'name': nameController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      }).then((_) {
                        globalDatabaseKey = newRef.key!;
                        print('Database Key: $globalDatabaseKey');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FarmerDetailsPage(
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              address: addressController.text,
                            ),
                          ),
                        );
                      });
                    }
                    else if (selectedRole == 'Seller') {
                      DatabaseReference newRef = databaseReference.child('user').push();
                      newRef.set({
                        'name': nameController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      }).then((_) {
                        globalDatabaseKey = newRef.key!;
                        print('Database Key: $globalDatabaseKey');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SellerDetailsPage(
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              address: addressController.text,
                            ),
                          ),
                        );
                      });
                    } else if (selectedRole == 'Customer') {
                      DatabaseReference newRef = databaseReference.child('user').push();
                      newRef.set({
                        'name': nameController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      }).then((_) {
                        globalDatabaseKey = newRef.key!;
                        print('Database Key: $globalDatabaseKey');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CHomePage(),
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
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

class RoleProvider extends ChangeNotifier {
  String _selectedRole = 'Farmer';

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
