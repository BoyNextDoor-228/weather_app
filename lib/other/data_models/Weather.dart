class Weather{
  late final num lon; // longitude ~~~~~~~~~~~~~~~~~~~~~~~ 10.99
  late final num lat; // latitude  ~~~~~~~~~~~~~~~~~~~~~~~ 44.34
  late final String description; // weather description ~~~~~ "пасмурно"
  late final String icon;        // weather icon  ~~~~~~~~~~~ "04d"
  late final num temp;        // temperature ~~~~~~~~~~~~~ 15.86
  late final num feelsLike;   // temperature feels like ~~ 15.3
  late final num pressure;   // atmospheric pressure ~~~~~~~~ 999
  late final num humidity;   // humidity ~~~~~~~~~~~~~~~~~~~~ 69
  late final num speed;   // wind speed ~~~~~~~~~~~~~~~~~~ 3.76
  late final String country; // country name ~~~~~~~~~~~~~~~~ "IT"
  late final String name;    // city name ~~~~~~~~~~~~~~~~~~~ "Zocca"
  late final num sunrise; // sunrise time ~~~~~~~~~~~~~~~~~~~ 1664428261
  late final num sunset;  // sunset time ~~~~~~~~~~~~~~~~~~~~ 1664470904


  Weather({required this.lon,
    required this.lat,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.speed,
    required this.country,
    required this.name,
    required this.sunrise,
    required this.sunset });

  Weather.toObject(Map<String, dynamic> json){
    lon = json["coord"]["lon"];
    lat = json["coord"]["lat"];
    description = json["weather"][0]["description"];
    icon = json["weather"][0]["icon"];
    temp = json["main"]["temp"];
    feelsLike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    speed = json["wind"]["speed"];
    country = json["sys"]["country"];
    name = json["name"];
    sunrise = json["sys"]["sunrise"];
    sunset = json["sys"]["sunset"];
  }
}