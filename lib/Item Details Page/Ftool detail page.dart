import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolDetails extends StatelessWidget {
  final dynamic tool;
  final rupeeSymbol = '\u20B9'; // Add this line

  ToolDetails({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text('Tool Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.asset(
                tool.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30),
            Text(
              tool.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Price for Renting: $rupeeSymbol${tool.rentalPrice}/day', // Update this line
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              tool.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Details:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Owner Name: Aman',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launch('tel:+919021600896');
                },
                child: Text('Call Owner'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
