import 'package:json_annotation/json_annotation.dart';
import "announcer.dart";
import "subordinatedAlbum.dart";
part 'track.g.dart';

@JsonSerializable()
class Track {
  Track();

  num id;
  String kind;
  // ignore: non_constant_identifier_names
  num category_id;
  // ignore: non_constant_identifier_names
  String track_title;
  // ignore: non_constant_identifier_names
  String track_tags;
  // ignore: non_constant_identifier_names
  String track_intro;
  // ignore: non_constant_identifier_names
  String cover_url_small;
  // ignore: non_constant_identifier_names
  String cover_url_middle;
  // ignore: non_constant_identifier_names
  String cover_url_large;
  Announcer announcer;
  num duration;
  // ignore: non_constant_identifier_names
  num play_count;
  // ignore: non_constant_identifier_names
  num favorite_count;
  // ignore: non_constant_identifier_names
  num comment_count;
  // ignore: non_constant_identifier_names
  num download_count;
  // ignore: non_constant_identifier_names
  num play_size_32;
  // ignore: non_constant_identifier_names
  num play_size_64;
  // ignore: non_constant_identifier_names
  num play_size_64_m4a;
  // ignore: non_constant_identifier_names
  num play_size_24_m4a;
  // ignore: non_constant_identifier_names
  num play_size_amr;
  // ignore: non_constant_identifier_names
  bool can_download;
  // ignore: non_constant_identifier_names
  num download_size;
  // ignore: non_constant_identifier_names
  SubordinatedAlbum subordinated_album;
  num source;
  // ignore: non_constant_identifier_names
  num updated_at;
  // ignore: non_constant_identifier_names
  num created_at;
  // ignore: non_constant_identifier_names
  num order_num;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
