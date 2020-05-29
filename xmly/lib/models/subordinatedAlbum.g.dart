// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subordinatedAlbum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubordinatedAlbum _$SubordinatedAlbumFromJson(Map<String, dynamic> json) {
  return SubordinatedAlbum()
    ..id = json['id'] as num
    ..album_title = json['album_title'] as String
    ..cover_url_small = json['cover_url_small'] as String
    ..cover_url_middle = json['cover_url_middle'] as String
    ..cover_url_large = json['cover_url_large'] as String;
}

Map<String, dynamic> _$SubordinatedAlbumToJson(SubordinatedAlbum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'album_title': instance.album_title,
      'cover_url_small': instance.cover_url_small,
      'cover_url_middle': instance.cover_url_middle,
      'cover_url_large': instance.cover_url_large
    };
