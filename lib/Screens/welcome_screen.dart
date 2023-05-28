import 'package:farmily/classes/language.dart';
import 'package:farmily/classes/language_constants.dart';
import 'package:farmily/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:farmily/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:farmily/Screens/first_look.dart';
import 'package:provider/provider.dart';
import 'package:farmily/Screens/Homescreen.dart';
import 'package:farmily/providers/location provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  static const String screenId = 'welcome';

  Future<void> _requestPermission() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      // Permission granted, do something here
    } else {
      // Permission denied, show an error message or request again
    }
  }

  @override
  Widget build(BuildContext context) {

    // Get the user's current location
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
    // Rest of the code
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    String countryCode = "+91";
    void showBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (AppLocalizations.of(context)!.login),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      (AppLocalizations.of(context)!.enterphoneno),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixText: '+91',
                        labelText: (AppLocalizations.of(context)!.digitsno),
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (value){
                        if(value.length ==10){
                          myState((){
                            _validPhoneNumber = true;
                          });
                        }else{
                          myState((){
                            _validPhoneNumber = false;
                          });
                        }
                      },
                      controller: _phoneNumberController, // this line assigns the controller to the TextField
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: _validPhoneNumber ? false:true,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: _validPhoneNumber ? Theme.of(context).primaryColor : Colors.grey,
                              ),
                              onPressed: () {
                                String number = '$countryCode${_phoneNumberController.text}';
                                auth.verifyPhone(context,number);
                                print("PHONE NUMBER");
                                print(number);
                              },
                              child: Text(_validPhoneNumber ? (AppLocalizations.of(context)!.cont): (AppLocalizations.of(context)!.enterno),
                                style: TextStyle(color: Colors.white), // set text color to black

                              ),
                            ),
                          ),
                        ),

                      ],
                    )

                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: FirstLook()),
                Text(
                  AppLocalizations.of(context)!.readytoorder,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: () async {
                    await _requestPermission();
                    await Provider.of<LocationProvider>(context, listen: false)
                        .getCurrentLocation();
                    // do something when the button is pressed
                  },
                  child: Text(AppLocalizations.of(context)!.setdeliveryloc,
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.alreadycust,
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    showBottomSheet(context);
                  },
                ),
              ],
            ),
            /*    Positioned(
              top: 20,
              right: 5,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),*/
            Positioned(
              top: 25,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  // Handle language icon tap
                },
                child: Icon(
                  Icons.language,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            DropdownButton<Language>(
              underline: const SizedBox(),
              onChanged: (Language? language) {
                // Handle language change here
              },
              items: Language.languageList().map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(e.name),
                    ],
                  ),
                ),
              ).toList(),
            ),

            DropdownButton<Language>(
              underline: const SizedBox(),
              iconSize: 0,
              onChanged: (Language? language) {
                // Handle language change here
              },
              items: Language.languageList().map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(e.name),
                    ],
                  ),
                ),
              ).toList(),
            ),

            DropdownButton<Language>(
              underline: const SizedBox(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, _locale);
                }
                // Handle language change here
              },
              items: Language.languageList().map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(e.name),
                    ],
                  ),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
