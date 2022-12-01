// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:clima_weather_app/screens/city_screen.dart';
import 'package:clima_weather_app/services/networking.dart';
import 'package:clima_weather_app/services/weather.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather/weather.dart';

class LocationScreen extends StatefulWidget {
  final weatherdata;
  const LocationScreen({
    Key? key,
    required this.weatherdata,
  }) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temp = 0;
  String weatherIcon = "";
  String cityname = "";
  String weathermsg = "";

  void updatedata(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temp = 0;
        weatherIcon = "error";
        weathermsg = "unable to find weather";
        cityname = "";
        return;
      }
      var temp1 = weatherdata['main']['temp'];
      temp = temp1.toInt();
      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weathermsg = weatherModel.getMessage(temp);
      cityname = weatherdata['name'];
    });
  }

  @override
  void initState() {
    updatedata(widget.weatherdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      updatedata(await weatherModel.getlocationweather());
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return CityScreen();
                      })));
                      NetworkHelper networkhelper = NetworkHelper(
                          url: '$openwe?q=$typedname&appid=$key&units=metric');
                      updatedata(await networkhelper.getdata());
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$temp°c",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermsg in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
