import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  String? _weatherInfo;
  bool _isLoading = false;
  String? _errorMessage;

  // Function to fetch weather based on the user's input city
  void getWeather(String city) async {
    setState(() {
      _isLoading = true;
      _weatherInfo = null;
      _errorMessage = null;
    });

    final weather = await _weatherService.getWeather(city);

    setState(() {
      _isLoading = false;
      if (weather != null) {
        _weatherInfo = """
City: ${city}
Temperature: ${weather['main']['temp']}°C
Weather: ${weather['weather'][0]['description']}
Humidity: ${weather['main']['humidity']}%
Wind Speed: ${weather['wind']['speed']} m/s
""";
      } else {
        _errorMessage = "Could not fetch weather for $city. Please try again.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field to enter city name
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter City",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      getWeather(_cityController.text.trim());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Search Button
            ElevatedButton(
              onPressed: () {
                if (_cityController.text.isNotEmpty) {
                  getWeather(_cityController.text.trim());
                }
              },
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),
            // Display weather information or errors
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _weatherInfo != null
                  ? Card(
                elevation: 5,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _weatherInfo!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
                  : _errorMessage != null
                  ? Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : const Center(
                child: Text(
                  "Enter a city name to fetch weather information.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}