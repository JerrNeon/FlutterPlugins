import 'package:json_annotation/json_annotation.dart';
import "announcer.dart";
import "subordinatedAlbum.dart";
part 'track.g.dart';

@JsonSerializable()
class Track {
    Track();

    num id;
    String kind;
    @JsonKey(name : 'category_id') int categoryId;
    @JsonKey(name : 'track_title') String trackTitle;
    @JsonKey(name : 'track_tags') String trackTags;
    @JsonKey(name : 'track_intro') String trackTntro;
    @JsonKey(name : 'cover_url_small') String coverUrlSmall;
    @JsonKey(name : 'cover_url_middle') String coverUrlMiddle;
    @JsonKey(name : 'cover_url_large') String coverUrlLarge;
    Announcer announcer;
    num duration;
    @JsonKey(name : 'play_count') int playCount;
    @JsonKey(name : 'favorite_count') int favoriteCount;
    @JsonKey(name : 'comment_count') int commentCount;
    @JsonKey(name : 'download_count') int downloadCount;
    @JsonKey(name : 'play_size_32') dynamic playSize32;
    @JsonKey(name : 'play_size_64') dynamic playSize64;
    @JsonKey(name : 'play_size_64_m4a') dynamic playSize64M4a;
    @JsonKey(name : 'play_size_24_m4a') dynamic playSize24M4a;
    @JsonKey(name : 'play_size_amr') dynamic playSizeAmr;
    @JsonKey(name : 'can_download') bool canDownload;
    @JsonKey(name : 'download_size') num downloadSize;
    // ignore: non_constant_identifier_names
    SubordinatedAlbum subordinated_album;
    num source;
    @JsonKey(name : 'updated_at') num updatedAt;
    @JsonKey(name : 'created_at') num createdAt;
    @JsonKey(name : 'order_num') int orderNum;
    
    factory Track.fromJson(Map<String,dynamic> json) => _$TrackFromJson(json);
    Map<String, dynamic> toJson() => _$TrackToJson(this);
}
