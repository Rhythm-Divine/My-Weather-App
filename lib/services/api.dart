import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/forecastData.dart';
import '../models/weatherData.dart';

class API {
  String url;
  final bool isforecast;
  API({required this.url, required this.isforecast});
  Future getData() async {
    final response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      return isforecast
          ? forecastFromJson(response.body)
          : currentWeatherFromJson(response.body);
    } else {
      throw TimeoutException('Failed to load');
    }
  }
}
