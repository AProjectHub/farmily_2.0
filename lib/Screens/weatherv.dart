import 'package:farmily/Screens/repo.dart';
import 'package:farmily/Screens/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wscreen extends StatefulWidget {
  const Wscreen({Key? key}) : super(key: key);

  @override
  State<Wscreen> createState() => _WscreenState();
}

class _WscreenState extends State<Wscreen> {
  WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
          hintColor: Colors.greenAccent,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Weather App"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context); // Navigates back to the previous screen
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        weatherModel = await Repo().getWeather("Pune");
                        print(weatherModel?.main?.temp ?? "error");
                        setState(() {});
                      },
                      child: Text("Get Weather Report"),
                    ),
                    SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      separatorBuilder: (context, index) => Divider(
                        height: 8,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            double temp = (weatherModel?.main?.temp ?? 0) / 10;
                            return Text(
                              "Temperature: ${temp.toStringAsFixed(1)}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );

                          case 1:
                            return Text(
                              "Description: ${weatherModel?.weather?.first.description}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          case 2:
                            return Text(
                              "Humidity: ${weatherModel?.main?.humidity}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          case 3:
                            return Text(
                              "Wind Speed: ${weatherModel?.wind?.speed}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          case 4:
                            return Text(
                              "Sunrise: ${_formatTimestamp(weatherModel?.sys?.sunrise)}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          case 5:
                            return Text(
                              "Sunset: ${_formatTimestamp(weatherModel?.sys?.sunset)}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          case 6:
                            return Text(
                              "Country: ${weatherModel?.sys?.country}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          default:
                            return Container();
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      "City: ${weatherModel?.name}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return "";
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toString();
  }
}
