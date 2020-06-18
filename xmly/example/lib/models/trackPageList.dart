import 'package:json_annotation/json_annotation.dart';
import 'package:xmly/xmly_plugin.dart';

part 'trackPageList.g.dart';

@JsonSerializable()
class TrackPageList {
  TrackPageList();

  @JsonKey(name: 'album_id')
  int albumId;
  @JsonKey(name: 'total_page')
  int totalPage;
  @JsonKey(name: 'total_count')
  int totalCount;
  @JsonKey(name: 'current_page')
  int currentPage;
  @JsonKey(name: 'album_title')
  String albumTitle;
  @JsonKey(name: 'album_intro')
  String albumIntro;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'cover_url_small')
  String coverUrlSmall;
  @JsonKey(name: 'cover_url_middle')
  String coverUrlMiddle;
  @JsonKey(name: 'cover_url_large')
  String coverUrlLarge;
  @JsonKey(name: 'can_download')
  bool canDownload;
  List<Track> tracks;

  factory TrackPageList.fromJson(Map<String, dynamic> json) =>
      _$TrackPageListFromJson(json);
  Map<String, dynamic> toJson() => _$TrackPageListToJson(this);
}
