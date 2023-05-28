import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class GroceryListScreen extends StatefulWidget {
  static const String screenId = 'grocery_list_screen';

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late DatabaseReference _groceriesRef;
  List<Map<String, dynamic>> _groceries = [];

  @override
  void initState() {
    super.initState();
    _groceriesRef = FirebaseDatabase.instance.reference().child('groceries');
    _groceriesRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _groceries = [];
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            final grocery = Map<String, dynamic>.from(value);
            grocery['key'] = key; // Add 'id' field to store the key of the grocery
            _groceries.add(grocery);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
      ),
      body: _groceries.isEmpty
          ? Center(
        child: const Text('No groceries available'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: _groceries.length,
        itemBuilder: (context, index) {
          final grocery = _groceries[index];
          final name = grocery['name'];
          final imageUrl = grocery['imageUrl'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryDetailScreen(grocery: grocery),
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

class GroceryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> grocery;

  const GroceryDetailScreen({required this.grocery});

  @override
  Widget build(BuildContext context) {
    final name = grocery['name'];
    final address = grocery['address'];
    final contactDetails = grocery['contactDetails'];
    final description = grocery['description'];
    final category = grocery['category'];
    final imageUrl = grocery['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Detail'),
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
                    initialValue: address ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: contactDetails ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Contact Details',
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
                    initialValue: category ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(
                        color: category != null ? Colors.black : Colors.grey,
                      ),
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
