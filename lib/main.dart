import 'package:farmily/classes/language_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:farmily/Screens/SplashScreen.dart';
import 'package:farmily/Screens/Scategory.dart';
import 'package:farmily/Screens/Bcategory.dart';
import 'package:farmily/Screens/welcome_screen.dart';
import 'package:farmily/Screens/Homescreen.dart';
import 'package:farmily/Forms/AddGrocery.dart';
import 'package:farmily/Forms/AddFertilisers.dart';
import 'package:farmily/Forms/AddSeeds.dart';
import 'package:farmily/Forms/addtools.dart';
import 'package:farmily/Forms/addGardeningtools.dart';
import 'package:farmily/Forms/addothers.dart';
import 'firebase_options.dart';
import 'package:farmily/providers/auth_provider.dart';
import 'package:farmily/providers/location provider.dart';
import 'package:provider/provider.dart';
import 'package:farmily/SignUpPages/SignUpPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider (
    providers: [
      ChangeNotifierProvider<LocationProvider>(
        create: (_) => LocationProvider(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider<RoleProvider>(
        create: (_) => RoleProvider(),
        child: MyApp(),
      ),
    ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}
class _MyAppState extends State<MyApp>{
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override

  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aman Ka Kaam',
      initialRoute: SplashScreen.screenId,
      routes: {
        SplashScreen.screenId: (context) => SplashScreen(),
        WelcomeScreen.screenId: (context) => WelcomeScreen(),
        SignUpPage.screenId: (context) => SignUpPage(),
        HomePage.screenId: (context) => HomePage(),
        SCategoryScreen.screenId: (context) => SCategoryScreen(),
        BCategoryScreen.screenId: (context) => BCategoryScreen(),
        AddGroceryScreen.screenId: (context) => AddGroceryScreen(),
        AddFertilisersScreen.screenId: (context) => AddFertilisersScreen(),
        AddSeedsSaplingsScreen.screenId: (context) => AddSeedsSaplingsScreen(),
        AddFarmingToolsScreen.screenId: (context) => AddFarmingToolsScreen(),
        AddGardeningToolsScreen.screenId: (context) => AddGardeningToolsScreen(),
        AddOthersScreen.screenId: (context) => AddOthersScreen(),
      },

      theme: ThemeData(
        primarySwatch: Colors.green,

      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: SplashScreen(),
    );
  }
}
