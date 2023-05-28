// news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<dynamic>> fetchNewsData() async {
    final apiKey = 'd12fe8b028a34d1bb4b729a83cf95a1f';
    final url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'];
      return articles;
    } else {
      throw Exception('Failed to fetch news data');
    }
  }
}

class WeatherService {
  Future<List<dynamic>> fetchNewsData() async {
    final apiKey = '182544c6da424c2aa5260308232805';
    final url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'];
      return articles;
    } else {
      throw Exception('Failed to fetch news data');
    }
  }
}
