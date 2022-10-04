import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/other/data_models/Weather.dart';
import 'package:flutter_module/search/search_bll/search_model.dart';

import '../../other/delegates/CitySearchDelegate.dart';
import '../../weather/weather_bll/weather_widgetmodel.dart';
import '../../weather/weather_ui/weather_screen.dart';
import '../search_ui/search_screen.dart';

abstract class ISearchWidgetModel extends IWidgetModel{
  ListenableState<EntityState<Weather>> get currentWeather;
}

class SearchWidgetModel extends WidgetModel<SearchScreen, SearchModel> implements ISearchWidgetModel{
  SearchWidgetModel(super.model);

  @override
  ListenableState<EntityState<Weather>> get currentWeather => model.currentWeather;

  void onGetWeatherButtonClick(){
    Navigator.push(context, MaterialPageRoute (
      builder: (BuildContext context) => WeatherScreen(wmFactory: (BuildContext context) => createWeatherWidgetModel(context, null)),
    ));
  }

  Future<List<String>> onGetCitiesSuggestion(String query){
    return model.getCitiesSuggestion(query);
  }

  Future<String?> onSearchButtonClick() {
    final result = showSearch(context: context, delegate: CitySearch());
    return result;
  }

}

SearchWidgetModel createSearchWidgetModel (BuildContext context) {
  return SearchWidgetModel(SearchModel());
}