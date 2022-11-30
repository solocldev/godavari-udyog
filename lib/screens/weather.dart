import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var apiKey = '94236490bdcfedabdb66ef6ebdc775df';
  var temperature = 77.77, long, lat;

  // https://api.openweathermap.org/data/2.5/weather?lat=17.1707&lon=74.6869&appid=${apiKey}&units=metric

  Future<String>? getData() async {
    var dist = MyApp.user['district_name'];
    if (dist == 'Sangli') {
      lat = 17.1707;
      long = 74.6869;
    } else if (dist == 'Satara') {
      lat = 17.5780;
      long = 74.0300;
    } else if (dist == 'Kolhapur') {
      lat = 16.5764;
      long = 74.1240;
    } else if (dist == 'Solapur') {
      lat = 17.6957;
      long = 75.5277;
    }
    try {
      var endpoint = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=${apiKey}&units=metric');
      var response = await http.get(endpoint);
      var body = jsonDecode(response.body);
      print(lat);
      temperature = body['main']['temp'];
      print(temperature);
      return temperature.toString();
    } catch (e) {
      print(e);
    }
    return '';
  }

  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xffFFF6EA)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return Text('Some Error occured');
                else {
                  return Container(
                    margin: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Weather Forecast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search for videos, shops and more',
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              MyApp.user['district_name']!,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffEC9A2A),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              ' ${snapshot.data}°',
                              style: TextStyle(fontSize: 80),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'couldy ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffEC9A2A),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
