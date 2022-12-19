import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:theme_provider/theme_provider.dart';

import '../models/forecastData.dart';
import '../models/weatherData.dart';
import '../services/locationHelper.dart';
import '../services/weatherHelper.dart';
import '../widgets/weather.dart';
import '../widgets/weatherForecast.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<CurrentWeather> weatherFuture = cityWeather('');
  Future<Forecast> forecastFuture = cityForecast('');
  Location location = Location();
  double lat = 11.23;
  double lon = 22.22;
  @override
  void initState() {
    if (SearchScreen.isQuerySearch && SearchScreen.controller.text.isNotEmpty) {
      weatherFuture = cityWeather(SearchScreen.controller.text);
      forecastFuture = cityForecast(SearchScreen.controller.text);
    } else {
      getData();
    }
    super.initState();
  }

  getData() async {
    await location.getCurrentLocation().then((v) {
      setState(() {
        lat = location.latitude!;
        lon = location.longitude!;

        weatherFuture = CurrLocationWeather(latitude: lat, longitude: lon);
        forecastFuture = currentLocationForecast(lat: lat, lon: lon);
      });
    });
  }

  Icon themeModeIcon() {
    return ThemeProvider.controllerOf(context).currentThemeId == 'dark-theme'
        ? const Icon(Icons.sunny)
        : const Icon(Icons.nights_stay);
  }

  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    // show();
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/world.png',
              height: 475,
              color: Colors.grey.withOpacity(.3),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: IconButton(
                  onPressed: () {
                    isDarkMode = !isDarkMode;

                    ThemeProvider.controllerOf(context).nextTheme();
                  },
                  icon: themeModeIcon(),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CurrLocation(
                future: weatherFuture,
              ),
              ForecastCard(
                future: forecastFuture,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      SearchScreen.controller.clear();
      SearchScreen.isQuerySearch = false;
    });
    super.dispose();
  }
}
