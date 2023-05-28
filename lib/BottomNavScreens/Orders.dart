import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  @override
  static const String screenId = 'Orders';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your order number:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Order number',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement order tracking logic
              },
              child: Text('Track Order'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderTrackingPage(),
  ));
}
