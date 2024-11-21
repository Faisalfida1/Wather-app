import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "a74f69dc0f56df8b0e7eaa2440c8b8b5";

  Future<Map<String, dynamic>?> getWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load weather data');
      return null;
    }
  }
}