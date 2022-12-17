import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../models/weatherData.dart';

class CurrLocation extends StatelessWidget {
  Future<CurrentWeather> future;

  var dateFormat = DateFormat('dd-MMM-yyyy');

  CurrLocation({required this.future, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeather>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateFormat.format(DateTime.now()),
                        style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                          ),
                          Text(
                            '${snapshot.data!.name},',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.sys.country,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Swing(
                          child: Image.asset(
                            weatherImage(snapshot.data!.weather.first.id),
                            height: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          snapshot.data!.weather.first.main,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            FadeInDown(
                              from: 20,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data!.main.temp.toStringAsFixed(0),
                                  style: const TextStyle(
                                      fontSize: 96,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 200, bottom: 30),
                              child: Text('°',
                                  style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 72,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center();
        }

        return const Center();
      },
    );
  }

  static String weatherImage(int condition) {
    late String assetImage;
    if (condition < 300) {
      if (condition < 210 || (condition > 230 && condition < 233)) {
        assetImage = 'assets/thunder-rain-cloud.png';
      } else if (condition < 220) {
        assetImage = 'assets/thunderonly-cloud.png';
      }
    } else if (condition < 400) {
      assetImage = 'assets/cloud-rain.png';
    } else if (condition < 600) {
      assetImage = 'assets/rain.png';
    } else if (condition < 700) {
      assetImage = 'assets/cloud-snow.png';
    } else if (condition < 800) {
      if (condition == 781) {
        assetImage = 'assets/Tornado.png';
      }
      assetImage = 'assets/misty-cloud.png';
    } else if (condition == 800) {
      assetImage = 'assets/sunPNG.png';
    } else if (condition < 805) {
      assetImage = 'assets/cloud.png';
    }
    return assetImage;
  }
}
