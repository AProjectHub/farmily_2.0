import 'package:flutter/material.dart';
import 'package:farmily/Forms/addGardeningtools.dart';
import 'package:farmily/Forms/AddFertilisers.dart';
import 'package:farmily/Forms/AddGrocery.dart';
import 'package:farmily/Forms/AddSeeds.dart';
import 'package:farmily/Forms/addtools.dart';
import 'package:farmily/Forms/addothers.dart';

class SCategoryScreen extends StatelessWidget {
  final double logoSize = 100.0;
  static const String screenId = 'Sell';
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
        title: Text('Sales Categories'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        padding: EdgeInsets.all(screenWidth * 0.05),
        mainAxisSpacing: screenWidth * 0.05,
        crossAxisSpacing: screenWidth * 0.05,
        children: <Widget>[
          _buildCategoryTile(context, 'Grocery', 'assets/Images/Grocery.png'),
          _buildCategoryTile(context, 'Fertilisers & Pesticides', 'assets/Images/fertilisers.png'),
          _buildCategoryTile(context, 'Seeds & Saplings', 'assets/Images/seeds.png'),
          _buildCategoryTile(context, 'Farming Tools', 'assets/Images/farming tools.png'),
          _buildCategoryTile(context, 'Gardening Tools', 'assets/Images/Gardening tools.png'),
          _buildCategoryTile(context, 'Others', 'assets/Images/others.png'),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (name == 'Grocery') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGroceryScreen(),
            ),
          );
        } else if (name == 'Fertilisers & Pesticides') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFertilisersScreen(),
            ),
          );
        } else if (name == 'Seeds & Saplings') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSeedsSaplingsScreen(),
            ),
          );
        } else if (name == 'Farming Tools') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFarmingToolsScreen(),
            ),
          );
        } else if (name == 'Gardening Tools') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGardeningToolsScreen(),
            ),
          );
        } else if (name == 'Others') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOthersScreen(),
            ),
          );
        }
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
