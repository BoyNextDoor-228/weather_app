import 'package:elementary/elementary.dart';
import 'package:flutter_module/other/data_models/Weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class WeatherModel extends ElementaryModel{
  String? city;
  String? _selectedCity;
  final apiKey = "588c399e615cf0910de552b7ba1f044b";
  final currentWeather = EntityStateNotifier<Weather>()..loading();

  WeatherModel(this.city);


  @override
  void init() {
    super.init();
    getWeather();
  }

  void getWeather() async {
    onCitySelected(city);
    if(_selectedCity != null){
      getWeatherByCity(_selectedCity);
    }
    else {
      getWeatherByCoords();
    }
  }

  void onCitySelected(String? city){
    _selectedCity = city;
  }


  void getWeatherByCity(String? city) async {
    final urlReq = "https://api.openweathermap.org/data/2.5/weather?q=$city&lang=ru&units=metric&appid=$apiKey";

    final rawData = await http.get(Uri.parse(urlReq));
    var dataString = JSON.jsonDecode(rawData.body);
    var weather = Weather.toObject(dataString);
    currentWeather.content(weather);
    print("================================== $dataString");
  }

  void getWeatherByCoords() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());
    final urlReq = "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&lang=ru&units=metric&appid=$apiKey";
    print(urlReq);

    final rawData = await http.get(Uri.parse(urlReq));
    var dataString = JSON.jsonDecode(rawData.body);
    var weather = Weather.toObject(dataString);
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $dataString");
    print("${weather.lat} \n${weather.lon} \n${weather.description} \n${weather.icon} \n${weather.temp} \n${weather.feelsLike} \n${weather.feelsLike} \n${weather.pressure} \n${weather.humidity} \n${weather.speed} \n${weather.country} \n${weather.sunrise} \n${weather.sunset} \n${weather.name}");
    currentWeather.content(weather);
  }

}