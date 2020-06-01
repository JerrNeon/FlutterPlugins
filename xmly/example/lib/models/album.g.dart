// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album()
    ..id = json['id'] as num
    ..kind = json['kind'] as String
    ..categoryId = json['category_id'] as int
    ..albumTitle = json['album_title'] as String
    ..albumTags = json['album_tags'] as String
    ..albumIntro = json['album_intro'] as String
    ..coverUrlSmall = json['cover_url_small'] as String
    ..coverUrlMiddle = json['cover_url_middle'] as String
    ..coverUrlLarge = json['cover_url_large'] as String
    ..tracksNaturalOrdered = json['tracks_natural_ordered'] as bool
    ..playCount = json['play_count'] as int
    ..favoriteCount = json['favorite_count'] as int
    ..shareCount = json['share_count'] as int
    ..subscribeCount = json['subscribe_count'] as int
    ..includeTrackCount = json['include_track_count'] as int;
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'category_id': instance.categoryId,
      'album_title': instance.albumTitle,
      'album_tags': instance.albumTags,
      'album_intro': instance.albumIntro,
      'cover_url_small': instance.coverUrlSmall,
      'cover_url_middle': instance.coverUrlMiddle,
      'cover_url_large': instance.coverUrlLarge,
      'tracks_natural_ordered': instance.tracksNaturalOrdered,
      'play_count': instance.playCount,
      'favorite_count': instance.favoriteCount,
      'share_count': instance.shareCount,
      'subscribe_count': instance.subscribeCount,
      'include_track_count': instance.includeTrackCount
    };
