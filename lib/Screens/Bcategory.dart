import 'package:flutter/material.dart';
import 'package:farmily/ListScreens/grocerylist.dart';
import 'package:farmily/ListScreens/Fertiliserlist.dart';
import 'package:farmily/ListScreens/seedslist.dart';
import 'package:farmily/ListScreens/Farmingtoolslist.dart';
import 'package:farmily/ListScreens/Gardening tools list.dart';
import 'package:farmily/ListScreens/Others%20list.dart';

class BCategoryScreen extends StatelessWidget {
  final double logoSize = 100.0;
  static const String screenId = 'Buy';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        backgroundColor: Colors.green,
        title: Text('Purchase Categories'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        padding: EdgeInsets.all(screenWidth * 0.05),
        mainAxisSpacing: screenWidth * 0.05,
        crossAxisSpacing: screenWidth * 0.05,
        children: <Widget>[
          _buildCategoryTile(context, 'Grocery', 'assets/Images/Grocery.png', GroceryListScreen()),
          _buildCategoryTile(context, 'Fertilisers & Pesticides', 'assets/Images/fertilisers.png', FertilisersListScreen()),
          _buildCategoryTile(context, 'Seeds & Saplings', 'assets/Images/seeds.png', SeedsScreen()),
          _buildCategoryTile(context, 'Farming Tools', 'assets/Images/farming tools.png', FarmingToolsListScreen()),
          _buildCategoryTile(context, 'Gardening Tools', 'assets/Images/Gardening tools.png', GardenToolScreen()),
          _buildCategoryTile(context, 'Others', 'assets/Images/others.png', OtherScreen()),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String name, String imagePath, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: logoSize,
              height: logoSize,
            ),
            SizedBox(height: 3.0),
            Text(
              name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
