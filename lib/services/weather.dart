import 'package:clima/services/location.dart';

import 'networking.dart';

class WeatherModel {
  final apiKey = '830ee35d066b8369ef6310ebd0616264';
  final serverURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$serverURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper helper = NetworkHelper(url: url);
    var decodedData = await helper.getData();
    return decodedData;
  }

  Future<dynamic> getLocationData() async {
    try {
      Location location = new Location();
      await location.getCurrentLocation();
      NetworkHelper helper = NetworkHelper(
          url:
              "$serverURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

      var decodedData = await helper.getData();
      return decodedData;
    } catch (e) {
      print(e);
    }
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
