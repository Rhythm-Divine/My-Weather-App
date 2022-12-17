import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'landingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme(
              id: 'dark-theme',
              data: ThemeData(
                  fontFamily: 'poppins',
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    elevation: 0,
                  )),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: Colors.transparent,
                      selectedItemColor: Colors.white,
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false),
                  useMaterial3: true,
                  textTheme: const TextTheme(
                      bodyMedium: TextStyle(color: Colors.white))),
              description: 'Dark Mode'),
          AppTheme(
              id: 'light-theme',
              data: ThemeData(
                fontFamily: 'poppins',
                brightness: Brightness.light,
                primaryColor: Colors.white,
                scaffoldBackgroundColor: Colors.white.withAlpha(250),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.blue,
                )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.black,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false),
                textTheme:
                    const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
                useMaterial3: true,
              ),
              description: 'Light Mode'),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (context) {
              return MaterialApp(
                theme: ThemeProvider.themeOf(context).data,
                debugShowCheckedModeBanner: false,
                home: const MainPage(),
              );
            },
          ),
        ));
  }
}
