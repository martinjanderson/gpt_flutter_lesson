import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherDetailsScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final weather = weatherData['weather'][0];
    final main = weatherData['main'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weatherData['name']}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              '${weather['description'].toUpperCase()}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Temperature: ${main['temp']}°F',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Feels Like: ${main['feels_like']}°F',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Humidity: ${main['humidity']}%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
