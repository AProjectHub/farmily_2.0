import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String PUNJABI = 'pa';
const String TELUGU = 'te';
const String HINDI = 'hi';
const String ASSAMESE = 'as';
const String MARATHI= 'mr';


Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case HINDI:
      return const Locale(HINDI, "");
    case MARATHI:
      return const Locale(MARATHI, "");
    case PUNJABI:
      return const Locale(PUNJABI, "");
    case TELUGU:
      return const Locale(TELUGU, "");
    case ASSAMESE:
      return const Locale(ASSAMESE, "");
    default:
      return const Locale(ENGLISH, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
