import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_module/other/data_models/Weather.dart';
import 'package:flutter_module/weather/weather_bll/weather_widgetmodel.dart';

class WeatherScreen extends ElementaryWidget<WeatherWidgetModel> {
  const WeatherScreen({ required WidgetModelFactory wmFactory, super.key }) : super(wmFactory) ;

  @override
  Widget build(WeatherWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async{
                await wm.onSearchButtonClick();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: EntityStateNotifierBuilder<Weather>(
        listenableEntityState: wm.currentWeather,
        builder: (_, info) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Text(info!.name),
          );
        },
        loadingBuilder: (_, __) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
