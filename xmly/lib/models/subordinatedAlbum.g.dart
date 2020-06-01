// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subordinatedAlbum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubordinatedAlbum _$SubordinatedAlbumFromJson(Map<String, dynamic> json) {
  return SubordinatedAlbum()
    ..id = json['id'] as num
    ..albumTitle = json['album_title'] as String
    ..coverUrlSmall = json['cover_url_small'] as String
    ..coverUrlMiddle = json['cover_url_middle'] as String
    ..coverUrlLarge = json['cover_url_large'] as String;
}

Map<String, dynamic> _$SubordinatedAlbumToJson(SubordinatedAlbum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'album_title': instance.albumTitle,
      'cover_url_small': instance.coverUrlSmall,
      'cover_url_middle': instance.coverUrlMiddle,
      'cover_url_large': instance.coverUrlLarge
    };
