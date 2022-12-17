import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';
import 'package:myweatherapp/screens/HomeScreen.dart';
import 'package:myweatherapp/screens/SearchScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List screens = [const HomeScreen(), const SearchScreen()];

  int curr = 0;

  void navigation(int index) {
    setState(() {
      curr = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[curr],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curr,
        onTap: navigation,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              activeIcon: Icon(IconlyBold.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.search),
              activeIcon: Icon(IconlyBold.search),
              label: 'Search')
        ],
      ),
    );
  }
}
