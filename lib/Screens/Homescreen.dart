import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:farmily/Screens/Scategory.dart';
import 'package:farmily/Screens/Bcategory.dart';
import 'package:farmily/Screens/searchbar.dart';
import 'package:farmily/providers/location provider.dart';
import 'package:farmily/Screens/slidingscreen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../BottomNavScreens/AI.dart';
import '../BottomNavScreens/Chatbot.dart';
import '../BottomNavScreens/IOT Monitor.dart';
import '../BottomNavScreens/Orders.dart';
import '../BottomNavScreens/Profile.dart';
import '../ListScreens/Farmingtoolslist.dart';
import '../ListScreens/Fertiliserlist.dart';
import '../ListScreens/Gardening tools list.dart';
import '../ListScreens/Others list.dart';
import '../ListScreens/grocerylist.dart';
import '../ListScreens/seedslist.dart';

class HomePage extends StatelessWidget {
  static const String screenId = 'Home';

  void _showUtilityOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 4.0, // Add elevation for shadow effect
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2.0), // Add green border
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0), // Add shadow color and opacity
                  spreadRadius: 2.0,
                  blurRadius: 5.0,
                  offset: Offset(0, 3), // Add shadow offset
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Utility Options',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.analytics,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Crop Prediction',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CropPrediction()),
                    );
                    // Handle Crop Prediction option
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.rotate_90_degrees_ccw,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Crop Rotation',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    // Handle Crop Rotation option
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings_remote,
                    color: Colors.green,
                  ),
                  title: Text(
                    'IoT Monitoring',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SensorDataScreen()),
                    );
                    // Handle IoT Monitoring option
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _requestPermission() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      // Permission granted, do something here
    } else {
      // Permission denied, show an error message or request again
    }
  }

  void _showVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Required'),
          content: Text('Be a verified seller first'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<LocationProvider>(context).currentPosition;

    // Create a FutureBuilder to load the current location name
    final Future<List<Placemark>> currentPlace = currentPosition != null
        ? placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude)
        : Future.value([]);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(70, 70),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 10), // Add empty space above the logo
                        Image.asset(
                          'assets/Images/logo.jpg',
                          height: 60,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  showSearch(context: context, delegate: SearchBarDelegate());
                },
                padding: EdgeInsets.only(right: 20.0, top: 15.0),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Location section
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: FutureBuilder<List<Placemark>>(
                        future: _requestPermission().then((_) => currentPlace),
                        builder: (BuildContext context, AsyncSnapshot<List<Placemark>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('Location data not available');
                          } else {
                            final currentAddress = snapshot.data![0];
                            return Column(
                              children: [
                                Text(
                                  '${currentAddress.locality}, ${currentAddress.administrativeArea} ${currentAddress.postalCode}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //Sliding Screens
              SlidingScreens(),

              //Buy sell Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 160.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BCategoryScreen()),
                          );
                        },
                        child: Text(
                          'Buy/Rent',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Add space here
                    SizedBox(
                      width: 160.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to category screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SCategoryScreen()),
                          );
                        },
                        child: Text(
                          'Sell/Rent',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Horizontal category Section
              Container(
                height: 115.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0), // add left padding of 10.0
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GroceryListScreen()),
                              );
                              // Do something when the "Grocery" category is tapped.
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.grass),
                                    SizedBox(height: 5.0),
                                    Text('Grocery'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FertilisersListScreen()),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.power),
                                    SizedBox(height: 5.0),
                                    Text('Fertilisers'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GardenToolScreen()),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.grass),
                                    SizedBox(height: 5.0),
                                    Text('GTools'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FarmingToolsListScreen()),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.grain),
                                    SizedBox(height: 5.0),
                                    Text('FTools'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SeedsScreen()),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.filter_vintage),
                                    SizedBox(height: 5.0),
                                    Text('Seedlings'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OtherScreen()),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 80.0,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.local_florist),
                                    SizedBox(height: 5.0),
                                    Text('Others'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              // Recommendations section
              Container(
                height: 205,
                width: 450,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 370.0,
                      height: 150.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Image.asset('assets/1.jpg'),
                      ),
                    ),
                    Container(
                      width: 370.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Image.asset('assets/2.jpg'),
                      ),
                    ),
                    Container(
                      width: 370.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Image.asset('assets/image3.jpg'),
                      ),
                    ),
                    Container(
                      width: 370.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Image.asset('assets/3.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            label: 'Utility',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
            // Handle home icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
            // Handle chat icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
              break;
            case 2:
            // Handle add icon tap
              _showUtilityOptions(context);
              break;
            case 3:
            // Handle orders icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderTrackingPage()),
              );
              break;
            case 4:
            // Handle profile icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}