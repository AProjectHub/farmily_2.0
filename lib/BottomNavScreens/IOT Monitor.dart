import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SensorDataScreen extends StatefulWidget {
  @override
  _SensorDataScreenState createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('SensorData');

  String temperatureInsight = '';
  String moistureInsight = '';
  String humidityInsight = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: StreamBuilder(
        stream: _databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.snapshot.value != null) {
            var data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

            if (data != null) {
              var humidity = data['humidity'];
              var moisture = data['moisture'];
              var moisturePercentage = (moisture / 1024) * 100;
              var temperature = data['temperature'];

              if (temperature > 48) {
                temperatureInsight = 'Plants are too heated';
              } else {
                temperatureInsight = 'Plants are at good temperature';
              }

              if (moisturePercentage > 80) {
                moistureInsight = 'Plants are well moisturized';
              } else {
                moistureInsight = 'Put some water in it';
              }

              if (humidity > 65) {
                humidityInsight =
                'It may promote the growth of mold and bacteria that cause plants to die and crops to fail';
              } else {
                humidityInsight = 'Plants are at good humidity';
              }

              return SleekSlider(
                temperature: temperature,
                humidity: humidity,
                moisturePercentage: moisturePercentage,
                temperatureInsight: temperatureInsight,
                moistureInsight: moistureInsight,
                humidityInsight: humidityInsight,
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SleekSlider extends StatelessWidget {
  final dynamic temperature;
  final dynamic humidity;
  final double moisturePercentage;
  final String temperatureInsight;
  final String moistureInsight;
  final String humidityInsight;

  SleekSlider({
    required this.temperature,
    required this.humidity,
    required this.moisturePercentage,
    required this.temperatureInsight,
    required this.moistureInsight,
    required this.humidityInsight,
  });

  Widget buildSlider({
    required double initialValue,
    required double minValue,
    required double maxValue,
    required Color trackColor,
    required Color progressBarColor,
    required Color labelColor,
    required String labelText,
    required String insightText,
  }) {
    double modifiedInitialValue = initialValue;

    if (labelText == 'Moisture') {
      if (initialValue == 100) {
        modifiedInitialValue = 0;
      } else if (initialValue == 0) {
        modifiedInitialValue = 100;
      }
    }

    return Row(
      children: [
        Expanded(
          child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
              size: 160,
              startAngle: 135,
              angleRange: 270,
              customWidths: CustomSliderWidths(progressBarWidth: 10),
              customColors: CustomSliderColors(
                hideShadow: true,
                trackColor: trackColor,
                progressBarColor: progressBarColor,
                shadowMaxOpacity: 20,
              ),
              infoProperties: InfoProperties(
                modifier: (double value) {
                  if (labelText == 'Temperature') {
                    return '${value.toStringAsFixed(0)}°C';
                  } else {
                    return '${value.toStringAsFixed(0)}%';
                  }
                },
              ),
            ),
            min: minValue,
            max: maxValue,
            initialValue: modifiedInitialValue.clamp(minValue, maxValue),
            onChange: null, // Disable the slider by setting onChange to null
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              insightText,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              buildSlider(
                initialValue: temperature.toDouble(),
                minValue: 0,
                maxValue: 100,
                trackColor: Colors.orange,
                progressBarColor: Colors.deepOrangeAccent,
                labelColor: Colors.orange,
                labelText: 'Temperature',
                insightText: 'Temperature between 20 - 25 degree Celsius is optimal',
              ),
              SizedBox(height: 20),
              buildSlider(
                initialValue: humidity.toDouble(),
                minValue: 0,
                maxValue: 100,
                trackColor: Colors.green,
                progressBarColor: Colors.greenAccent,
                labelColor: Colors.green,
                labelText: 'Humidity',
                insightText: 'An ideal humidity level for most adult plants is 60% to 70%',
              ),
              SizedBox(height: 20),
              buildSlider(
                initialValue: moisturePercentage,
                minValue: 0,
                maxValue: 100,
                trackColor: Colors.blue,
                progressBarColor: Colors.blueAccent,
                labelColor: Colors.blue,
                labelText: 'Moisture',
                insightText: 'The optimal range of soil moisture content for crops is between 20% and 60%',
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.green[50], // Set card background color
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Insights',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        temperatureInsight,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        moistureInsight,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        humidityInsight,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
