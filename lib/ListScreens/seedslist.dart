import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SeedsScreen extends StatefulWidget {
  static const String screenId = 'seeds_screen';

  @override
  _SeedsScreenState createState() => _SeedsScreenState();
}

class _SeedsScreenState extends State<SeedsScreen> {
  late DatabaseReference _seedsRef;
  List<Map<String, dynamic>> _seeds = [];

  @override
  void initState() {
    super.initState();
    _seedsRef = FirebaseDatabase.instance.reference().child('SeedsSaplings');
    _seedsRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _seeds = [];
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            final seed = Map<String, dynamic>.from(value);
            seed['key'] = key; // Add 'key' field to store the key of the seed
            _seeds.add(seed);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seeds'),
      ),
      body: _seeds.isEmpty
          ? Center(
        child: Text('No seeds available'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: _seeds.length,
        itemBuilder: (context, index) {
          final seed = _seeds[index];
          final name = seed['name'];
          final imageUrl = seed['imageUrl'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeedDetailScreen(seed: seed),
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

class SeedDetailScreen extends StatelessWidget {
  final Map<String, dynamic> seed;

  const SeedDetailScreen({required this.seed});

  @override
  Widget build(BuildContext context) {
    final name = seed['name'];
    final type = seed['type'];
    final description = seed['description'];
    final price = seed['price'];
    final imageUrl = seed['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Seed Detail'),
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
                    initialValue: type ?? '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Type',
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
                    initialValue: price != null ? price.toString() : '',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Price',
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
}
