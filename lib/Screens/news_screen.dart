import 'package:flutter/material.dart';
import 'news_service.dart';

class NewsScreen extends StatelessWidget {
  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
          // Modify the app bar's properties here
          backgroundColor: Colors.blue, // Set the background color
          centerTitle: true, // Center the title horizontally
          elevation: 0, // Remove the shadow
        ),
        body: FutureBuilder<List<dynamic>>(
          future: newsService.fetchNewsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final articles = snapshot.data!;
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Container(
                      width: 350,
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              article['urlToImage'] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            article['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to fetch news data'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
