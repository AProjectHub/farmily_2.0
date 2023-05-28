import 'dart:math';
import 'package:flutter/material.dart';

class MarketPricesScreen extends StatelessWidget {
  final List<String> farmYields;

  MarketPricesScreen({required this.farmYields});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Prices'),
      ),
      body: ListView.builder(
        itemCount: farmYields.length,
        itemBuilder: (BuildContext context, int index) {
          final yieldName = farmYields[index];
          final marketPrice = getRandomMarketPrice();

          return ListTile(
            title: Text(yieldName),
            subtitle: Text('Market Price: ₹$marketPrice'), // Use ₹ symbol for rupees
          );
        },
      ),
    );
  }

  // Generate random market price for testing
  String getRandomMarketPrice() {
    final random = Random();
    final price = random.nextDouble() * 100; // Generate a random price between 0 and 100
    return price.toStringAsFixed(2); // Convert price to a string with 2 decimal places
  }
}
