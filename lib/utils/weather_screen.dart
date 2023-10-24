import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '39a24fe0fbad45cf94c131257232410';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "Саратов"; // Город по умолчанию
  String weatherData = "Загрузка..."; // Данные о погоде
  String weatherApiEndpoint; // Объявление переменной API-запроса
  TextEditingController cityInputController = TextEditingController(); // Контроллер для текстового поля ввода

  @override
  void initState() {
    super.initState();
    // Инициализация API-запроса в методе initState
    weatherApiEndpoint =
    'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';
    fetchWeatherData(); // Начальное получение данных о погоде
  }

  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(weatherApiEndpoint));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final current = data['current']; // Дтсуп к  объект 'current' в ответе API

        final temperature = current['temp_c']; // Доступ к температуре (пример свойства)
        final condition = current['condition']['text']; // Доступ к состоянию погоды (пример свойства)

        setState(() {
          weatherData = "Температура: $temperature°C\n";
        });
      } else {
        setState(() {
          weatherData = "Ошибка при загрузке погоды";
        });
      }
    } catch (e) {
      setState(() {
        weatherData = "Ошибка при загрузке погоды: $e";
      });
    }
  }

  // Функция для ручного обновления данных о погоде
  void refreshWeatherData() {
    setState(() {
      weatherData = "Загрузка..."; // Сброс данных о погоде до состояния загрузки
    });
    fetchWeatherData(); // Запрос новых данных о погоде
  }

  // Функция для выполнения поиска погоды для указанного города
  void searchWeatherByCity() {
    final inputCity = cityInputController.text; // Получение введенного города
    setState(() {
      city = inputCity; // Обновление текущего города
      weatherApiEndpoint =
      'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city'; // Обновление API-запроса для нового города
    });
    fetchWeatherData(); // Запрос данных о погоде для нового города
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Погода в городе $city", // Отображение текущего города
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                weatherData, // Отображение данных о погоде
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: refreshWeatherData, // Кнопка "Обновить погоду"
                child: Text("Обновить погоду"),
              ),
              SizedBox(height: 20), // Промежуток
              TextField(
                controller: cityInputController, // Привязка контроллера к текстовому полю ввода
                decoration: InputDecoration(labelText: "Введите город"),
              ),
              ElevatedButton(
                onPressed: searchWeatherByCity, // Кнопка "Искать"
                child: Text("Искать"),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
