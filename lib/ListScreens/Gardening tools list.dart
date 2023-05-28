import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class GardenToolScreen extends StatefulWidget {
  static const String screenId = 'gardentoolscreen';

  @override
  _GardenToolScreenState createState() => _GardenToolScreenState();
}

class _GardenToolScreenState extends State<GardenToolScreen> {
  late DatabaseReference _gardenToolsRef;
  List<Map<String, dynamic>> _gardenTools = [];

  @override
  void initState() {
    super.initState();
    _gardenToolsRef = FirebaseDatabase.instance.reference().child('gardening_tools');
    _gardenToolsRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _gardenTools = [];
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            final gardenTool = Map<String, dynamic>.from(value);
            gardenTool['key'] = key; // Add 'id' field to store the key of the garden tool
            _gardenTools.add(gardenTool);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden Tools List'),
      ),
      body: _gardenTools.isEmpty
          ? Center(
        child: const Text('No garden tools available'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: _gardenTools.length,
        itemBuilder: (context, index) {
          final gardenTool = _gardenTools[index];
          final description = gardenTool['description'];
          final equipment = gardenTool['equipment'];
          final imageUrl = gardenTool['imageUrl'];
          final option = gardenTool['option'];
          final price = gardenTool['price'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GardenToolDetailScreen(gardenTool: gardenTool),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                      ),
                      child: imageUrl != null
                          ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                          : Container(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Equipment: ${equipment ?? ''}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          description ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Price: ${price ?? ''}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GardenToolDetailScreen extends StatelessWidget {
  final Map<String, dynamic> gardenTool;

  const GardenToolDetailScreen({required this.gardenTool});

  @override
  Widget build(BuildContext context) {
    final description = gardenTool['description'];
    final equipment = gardenTool['equipment'];
    final imageUrl = gardenTool['imageUrl'];
    final option = gardenTool['option'];
    final price = gardenTool['price'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Garden Tool Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: imageUrl != null
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Equipment: ${equipment ?? ''}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Option: ${option ?? ''}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: ${price ?? ''}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        _makePhoneCall('+919021600896'); // Replace the phone number with the desired number to call
                      },
                      child: Text('Contact'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _makePhoneCall(String phoneNumber) async {
    final phoneCallUrl = 'tel:$phoneNumber';
    try {
      await launch(phoneCallUrl);
    } catch (e) {
      throw 'Could not launch phone call: $e';
    }
  }
}
