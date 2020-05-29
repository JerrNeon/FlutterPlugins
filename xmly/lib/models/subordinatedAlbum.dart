import 'package:json_annotation/json_annotation.dart';

part 'subordinatedAlbum.g.dart';

@JsonSerializable()
class SubordinatedAlbum {
  SubordinatedAlbum();

  num id;
  // ignore: non_constant_identifier_names
  String album_title;
  // ignore: non_constant_identifier_names
  String cover_url_small;
  // ignore: non_constant_identifier_names
  String cover_url_middle;
  // ignore: non_constant_identifier_names
  String cover_url_large;

  factory SubordinatedAlbum.fromJson(Map<String, dynamic> json) =>
      _$SubordinatedAlbumFromJson(json);
  Map<String, dynamic> toJson() => _$SubordinatedAlbumToJson(this);
}
