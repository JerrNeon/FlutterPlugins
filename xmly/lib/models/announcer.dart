import 'package:json_annotation/json_annotation.dart';

part 'announcer.g.dart';

@JsonSerializable()
class Announcer {
  Announcer();

  num id;
  String kind;
  String nickname;
  // ignore: non_constant_identifier_names
  String avatar_url;
  // ignore: non_constant_identifier_names
  bool is_verified;
  // ignore: non_constant_identifier_names
  num anchor_grade;

  factory Announcer.fromJson(Map<String, dynamic> json) =>
      _$AnnouncerFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncerToJson(this);
}
