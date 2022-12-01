// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:clima_weather_app/screens/location_screen.dart';
import 'package:clima_weather_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getlocation() async {
    WeatherModel weather = WeatherModel();
    var weatherdata = await weather.getlocationweather();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => LocationScreen(
                  weatherdata: weatherdata,
                ))));
  }

  @override
  void initState() {
    getlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
