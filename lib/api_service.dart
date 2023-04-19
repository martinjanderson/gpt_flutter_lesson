import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/env.dart';

class ApiService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = Env.open_weather_map_api_key;

  Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
