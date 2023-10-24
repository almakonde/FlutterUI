import 'package:flutter/material.dart';
import './utils/input_form_screen.dart';
import './utils/calculator_screen.dart';
import './utils/weather_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Forms Test',
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(primarySwatch: Colors.grey),
      supportedLocales: [const Locale('en', '')],
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Scrollable Screens'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Экран 1'),
                Tab(text: 'Экран 2'),
                Tab(text: 'Экран 3'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              InputFormScreen(),
              SecondCalcScreen(),
              WeatherScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
