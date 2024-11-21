import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final WeatherService _weatherService = WeatherService();
  TextEditingController cityController = TextEditingController();
  String? weatherInfo;
  bool _isLoading = false;

  void getWeather() async {
    setState(() {
      _isLoading = true;
    });

    final weather = await _weatherService.getWeather(cityController.text.trim());

    setState(() {
      _isLoading = false;
      weatherInfo = weather != null
          ? "Temperature: ${weather['main']['temp']}°C\nWeather: ${weather['weather'][0]['description']}"
          : "Weather data not found.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: "Enter City"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getWeather,
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : weatherInfo != null
                ? Text(weatherInfo!)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}