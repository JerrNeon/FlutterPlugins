import 'package:json_annotation/json_annotation.dart';

part 'subordinatedAlbum.g.dart';

@JsonSerializable()
class SubordinatedAlbum {
    SubordinatedAlbum();

    num id;
    @JsonKey(name : 'album_title') String albumTitle;
    @JsonKey(name : 'cover_url_small') String coverUrlSmall;
    @JsonKey(name : 'cover_url_middle') String coverUrlMiddle;
    @JsonKey(name : 'cover_url_large') String coverUrlLarge;
    
    factory SubordinatedAlbum.fromJson(Map<String,dynamic> json) => _$SubordinatedAlbumFromJson(json);
    Map<String, dynamic> toJson() => _$SubordinatedAlbumToJson(this);
}
