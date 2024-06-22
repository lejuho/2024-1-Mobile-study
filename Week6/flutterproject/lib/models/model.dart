import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Model {
  Model({
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.id,
    required this.name,
    required this.cod,
    required this.wind,
  });

  final List<Weather> weather;
  final String base;
  final Main main;
  final double visibility;
  final Cloud clouds;
  final int dt;
  final Sys sys;
  final int id;
  final String name;
  final int cod;
  final Wind wind;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  get model => null;

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

@JsonSerializable()
class Coordinate {
  Coordinate({
    required this.lon,
    required this.lat,
  });

  final double lon, lat;

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}

@JsonSerializable()
class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Main {
  Main({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.temp_min,
    required this.temp_max,
  });

  final double temp;
  final double pressure;
  final double humidity;
  final double temp_min;
  final double temp_max;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final double deg;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Cloud {
  Cloud({
    required this.all,
  });

  final double all;

  factory Cloud.fromJson(Map<String, dynamic> json) => _$CloudFromJson(json);

  Map<String, dynamic> toJson() => _$CloudToJson(this);
}

@JsonSerializable()
class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.message,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final int? type;
  final int? id;
  final double? message;
  final String country;
  final int sunrise;
  final int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
