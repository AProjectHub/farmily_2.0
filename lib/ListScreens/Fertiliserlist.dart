import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class FertilisersListScreen extends StatefulWidget {
  static const String screenId = 'fertilisers_list_screen';

  @override
  _FertilisersListScreenState createState() => _FertilisersListScreenState();
}

class _FertilisersListScreenState extends State<FertilisersListScreen> {
  late DatabaseReference _fertilisersRef;
  List<Map<String, dynamic>> _fertilisers = [];

  @override
  void initState() {
    super.initState();
    _fertilisersRef = FirebaseDatabase.instance.reference().child('fertilizers');
    _fertilisersRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _fertilisers = [];
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            final fertiliser = Map<String, dynamic>.from(value);
            fertiliser['key'] = key; // Add 'key' field to store the key of the fertiliser
            _fertilisers.add(fertiliser);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilisers List'),
      ),
      body: _fertilisers.isEmpty
          ? Center(
        child: Text('No fertilisers available'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: _fertilisers.length,
        itemBuilder: (context, index) {
          final fertiliser = _fertilisers[index];
          final name = fertiliser['name'];
          final imageUrl = fertiliser['imageUrl'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FertiliserDetailScreen(fertiliser: fertiliser),
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
                      child: imageUrl != null ? Image.network(imageUrl, fit: BoxFit.cover) : Container(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

class FertiliserDetailScreen extends StatelessWidget {
  final Map<String, dynamic> fertiliser;

  const FertiliserDetailScreen({required this.fertiliser});

  @override
  Widget build(BuildContext context) {
    final name = fertiliser['name'];
    final brand = fertiliser['brand'];
    final description = fertiliser['description'];
    final price = fertiliser['price'];
    final imageUrl = fertiliser['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fertiliser Detail'),
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
              child: imageUrl != null ? Image.network(imageUrl, fit: BoxFit.cover) : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: brand ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Brand',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: description ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: price ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Price',
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
