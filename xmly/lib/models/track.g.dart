// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track()
    ..id = json['id'] as num
    ..kind = json['kind'] as String
    ..categoryId = json['category_id'] as int
    ..trackTitle = json['track_title'] as String
    ..trackTags = json['track_tags'] as String
    ..trackTntro = json['track_intro'] as String
    ..coverUrlSmall = json['cover_url_small'] as String
    ..coverUrlMiddle = json['cover_url_middle'] as String
    ..coverUrlLarge = json['cover_url_large'] as String
    ..announcer = json['announcer'] == null
        ? null
        : Announcer.fromJson(json['announcer'] as Map<String, dynamic>)
    ..duration = json['duration'] as num
    ..playCount = json['play_count'] as int
    ..favoriteCount = json['favorite_count'] as int
    ..commentCount = json['comment_count'] as int
    ..downloadCount = json['download_count'] as int
    ..playSize32 = json['play_size_32'] as int
    ..playSize64 = json['play_size_64'] as int
    ..playSize64M4a = json['play_size_64_m4a'] as int
    ..playSize24M4a = json['play_size_24_m4a'] as int
    ..playSizeAmr = json['play_size_amr'] as int
    ..canDownload = json['can_download'] as bool
    ..downloadSize = json['download_size'] as num
    ..subordinated_album = json['subordinated_album'] == null
        ? null
        : SubordinatedAlbum.fromJson(
            json['subordinated_album'] as Map<String, dynamic>)
    ..source = json['source'] as num
    ..updatedAt = json['updated_at'] as num
    ..createdAt = json['created_at'] as num
    ..orderNum = json['order_num'] as int;
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'category_id': instance.categoryId,
      'track_title': instance.trackTitle,
      'track_tags': instance.trackTags,
      'track_intro': instance.trackTntro,
      'cover_url_small': instance.coverUrlSmall,
      'cover_url_middle': instance.coverUrlMiddle,
      'cover_url_large': instance.coverUrlLarge,
      'announcer': instance.announcer,
      'duration': instance.duration,
      'play_count': instance.playCount,
      'favorite_count': instance.favoriteCount,
      'comment_count': instance.commentCount,
      'download_count': instance.downloadCount,
      'play_size_32': instance.playSize32,
      'play_size_64': instance.playSize64,
      'play_size_64_m4a': instance.playSize64M4a,
      'play_size_24_m4a': instance.playSize24M4a,
      'play_size_amr': instance.playSizeAmr,
      'can_download': instance.canDownload,
      'download_size': instance.downloadSize,
      'subordinated_album': instance.subordinated_album,
      'source': instance.source,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'order_num': instance.orderNum
    };
