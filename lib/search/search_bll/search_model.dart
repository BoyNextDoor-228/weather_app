import 'package:elementary/elementary.dart';
import 'package:flutter_module/other/data_models/Weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class SearchModel extends ElementaryModel{
  final currentWeather = EntityStateNotifier<Weather>()..loading();
  final currentCity = EntityStateNotifier<String>()..loading();

  final apiKey = "588c399e615cf0910de552b7ba1f044b";

  Future<List<String>> getCitiesSuggestion(String query) async{
    final urlReq = "http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey";
    final rawData = await http.get(Uri.parse(urlReq));
    final dataString = JSON.jsonDecode(rawData.body);
    print(dataString);
    return dataString.map<String>((json) {
      final city = json["name"];
      final country = json["country"];
      return '$city, $country';
    }).toList();
  }

  // void getWeatherByCity(String city) async {
  //   const apiKey = "588c399e615cf0910de552b7ba1f044b";
  //   final urlReq = "https://api.openweathermap.org/data/2.5/weather?q=$city&lang=ru&appid=$apiKey";
  //
  //   final rawData = await http.get(Uri.parse(urlReq));
  //   var dataString = JSON.jsonDecode(rawData.body);
  //   print(dataString);
  // }

}