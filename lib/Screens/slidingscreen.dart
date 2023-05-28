import 'dart:async';
import 'package:farmily/Screens/weatherv.dart';
import 'package:flutter/material.dart';
import 'news_screen.dart';
import 'market_prices_screen.dart'; // Import the new screen

class SlidingScreens extends StatefulWidget {
  const SlidingScreens({Key? key}) : super(key: key);

  @override
  _SlidingScreensState createState() => _SlidingScreensState();
}

class _SlidingScreensState extends State<SlidingScreens> {
  final PageController _controller = PageController(initialPage: 0);
  final List<String> _screenImages = [
    'assets/news/news.jpg',
    'assets/news/OIP.jpeg',
    'assets/news/mp.jpeg',
  ];

  final List<String> _farmYields = [
    'Corn',
    'Wheat',
    'Rice',
    'Potatoes',
    'Tomatoes',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      final nextPage = (_controller.page!.toInt() + 1) % _screenImages.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  void navigateToNewsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsScreen()),
    );
  }

  void navigateToOtherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Wscreen()),
    );
  }

  void navigateToMarketPricesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarketPricesScreen(farmYields: _farmYields)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: _screenImages.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                navigateToNewsPage();
              } else if (index == 1) {
                navigateToOtherPage();
              } else if (index == 2) {
                navigateToMarketPricesPage();
              }
            },
            child: Container(
              width: 370.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                _screenImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
