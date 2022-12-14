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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
