import 'package:clima_weather_app/services/location.dart';
import 'package:clima_weather_app/services/networking.dart';

const String key = "effc03426c69cfcc789c950849340e50";
const String openwe = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getcurrentlocation();
    String weburl =
        '$openwe?lat=${location.latitude}&lon=${location.longitude}&appid=$key&units=metric';
    NetworkHelper networkhelper = NetworkHelper(url: weburl);
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
