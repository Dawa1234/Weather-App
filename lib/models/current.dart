import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/condition.dart';
part 'current.g.dart';

@JsonSerializable()
class Current {
  int? last_updated_epoch;
  String? last_updated;
  double? temp_c;
  double? temp_f;
  int? is_day;
  Condition? condition;
  double? uv;

  Current(
      {this.last_updated_epoch,
      this.last_updated,
      this.temp_c,
      this.temp_f,
      this.is_day,
      this.condition,
      this.uv});
  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}
