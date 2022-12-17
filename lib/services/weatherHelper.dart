import '../models/forecastData.dart';
import '../models/weatherData.dart';
import 'api.dart';

const apiKey = 'cb30f7e509584b6abf0b41e193202e96';

const weatherUrl = 'http://api.openweathermap.org/data/2.5/weather';
const forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

Future<CurrentWeather> CurrLocationWeather(
    {required double latitude, required double longitude}) async {
  String url =
      '$weatherUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: false);
  return await api.getData();
}

Future<Forecast> currentLocationForecast(
    {required double lat, required double lon}) async {
  String url = '$forecastUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: true);
  return await api.getData();
}

Future<CurrentWeather> cityWeather(String city) async {
  String url = '$weatherUrl?q=$city&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: false);
  return await api.getData();
}

Future<Forecast> cityForecast(String city) async {
  String url = '$forecastUrl?q=$city&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: true);
  return await api.getData();
}
