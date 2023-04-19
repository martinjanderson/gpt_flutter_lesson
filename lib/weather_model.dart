import 'package:flutter/material.dart';

class WeatherModel with ChangeNotifier {
  List<String> _weatherDataList = [];

  List<String> get weatherDataList => _weatherDataList;

  void setWeatherDataList(List<String> dataList) {
    _weatherDataList = dataList;
    notifyListeners();
  }
}
