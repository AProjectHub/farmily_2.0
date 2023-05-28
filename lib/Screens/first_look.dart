import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:farmily/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstLook extends StatefulWidget {
  @override
  _FirstLookState createState() => _FirstLookState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

List<Widget> _pages(BuildContext context) {
  return [
    Column(
      children: [
        Expanded(child: Image.asset('assets/Images/grocerystore.png')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (AppLocalizations.of(context)!.orderonline),
            style: kPageViewTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('assets/Images/enteraddress.png')),
        Text(
          (AppLocalizations.of(context)!.delloc),
          style: kPageViewTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('assets/Images/delivery.png')),
        Text(
          (AppLocalizations.of(context)!.quickdel),
          style: kPageViewTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('assets/Images/farmtools.png')),
        Text(
          (AppLocalizations.of(context)!.brfarm),
          style: kPageViewTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('assets/Images/location.png')),
        Text(
          (AppLocalizations.of(context)!.findseller),
          style: kPageViewTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ];
}

class _FirstLookState extends State<FirstLook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: _pages(context),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          DotsIndicator(
            dotsCount: _pages(context).length,
            position: _currentPage.toDouble(),
            decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                activeColor: Colors.deepOrangeAccent
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

