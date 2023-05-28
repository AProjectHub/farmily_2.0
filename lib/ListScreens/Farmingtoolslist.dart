import 'package:flutter/material.dart';
import 'package:farmily/Item%20Details%20Page/Ftool%20detail%20page.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmingTool {
  String name;
  String image;
  String description;
  double price;
  double rentalPrice;

  FarmingTool({required this.name, required this.image, required this.description, required this.price, required this.rentalPrice});
}

class FarmingToolsListScreen extends StatelessWidget {
  static const String screenId = 'Ftools';
  final List<FarmingTool> _tools = [
    FarmingTool(
      name: 'Tractor',
      image: 'assets/toolshard/tract.jpeg',
      description: 'A powerful vehicle used for pulling and pushing heavy loads on the farm.',
      price: 150000.00,
      rentalPrice: 25000.00,
    ),
    FarmingTool(
      name: 'Plow',
      image: 'assets/toolshard/plow.jpeg',
      description: 'A farm tool used for preparing soil for planting.',
      price: 5000.00,
      rentalPrice: 1000.00,
    ),
    FarmingTool(
      name: 'Harvesting Machine',
      image: 'assets/toolshard/har.jpeg',
      description: 'A machine used for reaping and threshing crops.',
      price: 100000.00,
      rentalPrice: 20000.00,
    ),
    FarmingTool(
      name: 'Seeder',
      image: 'assets/toolshard/seeder.jpg',
      description: 'A tool used for planting seeds in rows.',
      price: 8000.00,
      rentalPrice: 1500.00,
    ),
    FarmingTool(
      name: 'Hay Rake',
      image: 'assets/toolshard/hay rake.jpeg',
      description: 'A tool used for gathering hay into rows for easier collection.',
      price: 2000.00,
      rentalPrice: 400.00,
    ),
  ];

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
        title: Text('Farming Tools'),
        backgroundColor: Colors.green,

      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Display two items per row
          childAspectRatio: 85/90, // Set aspect ratio of images
        ),
        itemCount: _tools.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to tool details page
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      _tools[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _tools[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price for Selling: \u20B9 ${_tools[index].price}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price for Renting: \u20B9 ${_tools[index].rentalPrice}/day',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            // Implement buying functionality
                          },
                          child: Text('Buy'),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToolDetails(tool: _tools[index]),
                              ),
                            );
                          },
                          child: Text('Rent'),
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
                ],
              ),
            ),
          );
        },
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