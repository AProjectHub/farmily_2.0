import 'package:flutter/material.dart';
import 'package:farmily/Forms/AddGrocery.dart';
import 'package:farmily/Forms/AddFertilisers.dart';
import 'package:farmily/Forms/AddSeeds.dart';
import 'package:farmily/Forms/addtools.dart';
import 'package:farmily/Forms/addGardeningtools.dart';
import 'package:farmily/Forms/addothers.dart';

class CategoryListScreen extends StatelessWidget {
  final bool? isForForm;
  static const String screenId = 'category_list_screen';

  const CategoryListScreen({Key? key, this.isForForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          isForForm == true ? 'Select Category' : 'Categories',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        'name': 'Grocery',
        'icon': Icons.shopping_cart,
      },
      {
        'name': 'Fertilisers & Pesticides',
        'icon': Icons.eco,
      },
      {
        'name': 'Seeds & Saplings',
        'icon': Icons.spa,
      },
      {
        'name': 'Farming Tools',
        'icon': Icons.agriculture,
      },
      {
        'name': 'Gardening Tools',
        'icon': Icons.grass,
      },
      {
        'name': 'Others',
        'icon': Icons.category,
      },
    ];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: ((context, index) {
        String category = categories[index]['name'];
        IconData icon = categories[index]['icon'];

        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            onTap: () {
              switch (category) {
                case 'Grocery':
                  Navigator.pushNamed(
                    context,
                    AddGroceryScreen.screenId,
                  );
                  break;
                case 'Fertilisers & Pesticides':
                  Navigator.pushNamed(
                    context,
                    AddFertilisersScreen.screenId,
                  );
                  break;
                case 'Seeds & Saplings':
                  Navigator.pushNamed(
                    context,
                    AddSeedsSaplingsScreen.screenId,
                  );
                  break;
                case 'Farming Tools':
                  Navigator.pushNamed(
                    context,
                    AddFarmingToolsScreen.screenId,
                  );
                  break;
                case 'Gardening Tools':
                  Navigator.pushNamed(
                    context,
                    AddGardeningToolsScreen.screenId,
                  );
                  break;
                case 'Others':
                  Navigator.pushNamed(
                    context,
                    AddOthersScreen.screenId,
                  );
                  break;
              // Add cases for other categories as needed
              }
            },
            leading: Icon(icon),
            title: Text(
              category,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
        );
      }),
    );
  }
}
