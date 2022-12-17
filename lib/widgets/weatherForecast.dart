import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../landingPage.dart';
import '../models/forecastData.dart';
import '../screens/SearchScreen.dart';
import 'weather.dart';

class ForecastCard extends StatefulWidget {
  ForecastCard({required this.future, Key? key}) : super(key: key);
  Future<Forecast> future;

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  var dateFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Flexible(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.16),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideInDown(
                            child: Image.asset(
                              CurrLocation.weatherImage(
                                  data!.list[index].weather.first.id),
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            dateFormat
                                .format(data.list[index].dtTxt)
                                .toLowerCase(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              '${data.list[index].main.temp.toStringAsFixed(0)}°',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else if (snapshot.hasError) {
          if (SearchScreen.isQuerySearch) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 500),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Please enter the city name correctly',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            SearchScreen.isQuerySearch = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        },
                        child: const Text(
                          'Check My Location Weather',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        return const Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(top: 200),
            child: SpinKitSpinningLines(color: Colors.blueAccent),
          ),
        );
      },
    );
  }
}
