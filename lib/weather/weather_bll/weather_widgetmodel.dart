import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/other/data_models/Weather.dart';
import 'package:flutter_module/weather/weather_bll/weather_model.dart';

import '../../other/delegates/CitySearchDelegate.dart';
import '../weather_ui/weather_screen.dart';

abstract class IWeatherWidgetModel extends IWidgetModel{
  ListenableState<EntityState<Weather>> get currentWeather;
}

class WeatherWidgetModel extends WidgetModel<WeatherScreen, WeatherModel> implements IWeatherWidgetModel{
  WeatherWidgetModel({ required WeatherModel model }) : super(model);

  Future<String?> onSearchButtonClick() {
    final result = showSearch(context: context, delegate: CitySearch());
    return result;
  }

  @override
  ListenableState<EntityState<Weather>> get currentWeather => model.currentWeather;

  void onInit(String city){
    model.getWeatherByCity(city);
  }

}
WeatherWidgetModel createWeatherWidgetModel (BuildContext context, String? city) {
  return WeatherWidgetModel(model: WeatherModel(city));
}

