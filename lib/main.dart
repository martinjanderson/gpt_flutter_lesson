import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'weather_details_screen.dart';
import 'weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherModel(),
      child: MaterialApp(
        title: 'Weather Forecast App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.deepOrange),
        ),
        home: WeatherHomePage(title: "Weather Forecast"),
      ),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final _cityNameController = TextEditingController();
  double _opacity = 0.0;
  Duration _duration = Duration(seconds: 1);
  String _cityName = '';
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/clear-sky.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24.0),
                TextField(
                  controller: _cityNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter a city name',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    List<String> cityNames = [
                      'London',
                      'New York',
                      'Tokyo',
                      'Sydney'
                    ];
                    if (_cityNameController.text.isNotEmpty) {
                      cityNames.add(_cityNameController.text);
                    }
                    _fetchWeatherData(cityNames);
                    //_fetchWeatherData(_cityNameController.text);
                  },
                  child: const Text('Get Weather'),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: _duration,
                    child: ListView.builder(
                      itemCount: Provider.of<WeatherModel>(context)
                          .weatherDataList
                          .length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            Provider.of<WeatherModel>(context)
                                .weatherDataList[index],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchWeatherData(List<String> cityNames) async {
    List<String> weatherData = [];

    // Skip animation and set opacity to 0 immediately
    setState(() {
      _opacity = 0.0;
      _duration = Duration(seconds: 0);
    });

    for (String cityName in cityNames) {
      try {
        final data = await _apiService.fetchWeatherData(cityName);
        weatherData.add('${data['name']}: ${data['main']['temp']}°F');
        //_navigateToWeatherDetails(data);
      } catch (error) {
        weatherData.add('Failed to load weather data for $cityName');
      }
    }

    setState(() {
      _opacity = 1.0;
      _duration = Duration(seconds: 1);
    });

    Provider.of<WeatherModel>(context, listen: false)
        .setWeatherDataList(weatherData);
  }

  void _navigateToWeatherDetails(Map<String, dynamic> weatherData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherDetailsScreen(weatherData: weatherData),
      ),
    );
  }
}
