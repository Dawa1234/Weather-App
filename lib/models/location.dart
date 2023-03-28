import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tz_id;
  int? locatime_epoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tz_id,
      this.locatime_epoch,
      this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
