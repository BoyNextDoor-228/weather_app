import 'package:flutter/material.dart';
import 'package:flutter_module/search/search_bll/search_model.dart';
import 'package:flutter_module/search/search_bll/search_widgetmodel.dart';

import '../../weather/weather_bll/weather_widgetmodel.dart';
import '../../weather/weather_ui/weather_screen.dart';

  class CitySearch extends SearchDelegate<String>{
  List<String> suggestionsList = ["Munich", "London", "Hamburg", "Moscow", "Miami"];
  late List<String> recentCities = ['Munich', 'Hamburg', 'London'];


  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if(query.isEmpty){
          close(context, '');
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => WeatherScreen(wmFactory: (BuildContext context) => createWeatherWidgetModel(context, query));

  @override
  Widget buildSuggestions(BuildContext context) {

    // final suggestions = query.isEmpty ? recentCities : suggestionsList.where((city) {
    //   final cityLowerCase = city.toLowerCase();
    //   final queryLowerCase = query.toLowerCase();
    //   return cityLowerCase.startsWith(queryLowerCase);
    // }).toList();

    return FutureBuilder<List<String>>(
        future: SearchWidgetModel(SearchModel()).onGetCitiesSuggestion(query.isEmpty ? recentCities[0] : query),
        builder: (context, snapshot) {
          if (query.isEmpty) return const Text("No suggestions");
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if(snapshot.hasError || snapshot.data!.isEmpty){
                return const Text("No suggestions");
              }
              else {
                return buildSuggestionsSuccess(snapshot.data!);
              }
          }
        },
    );
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index){
      final suggestion = suggestions[index];
      return ListTile(
          onTap: () {
            query = suggestion;
            showResults(context);
          },
          leading: const Icon(Icons.location_city),
          title: Text(suggestion)
      );
    },
  );

}

// @override
// Widget buildSuggestions(BuildContext context) {
//   SearchWidgetModel(SearchModel()).onGetCitiesSuggestion(query);
//   final suggestions = query.isEmpty ? recentCities : suggestionsList.where((city) {
//     final cityLowerCase = city.toLowerCase();
//     final queryLowerCase = query.toLowerCase();
//     return cityLowerCase.startsWith(queryLowerCase);
//   }).toList();
//
//   return buildSuggestionsSuccess(suggestions);
// }