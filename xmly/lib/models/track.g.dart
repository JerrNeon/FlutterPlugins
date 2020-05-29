// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track()
    ..id = json['id'] as num
    ..kind = json['kind'] as String
    ..category_id = json['category_id'] as num
    ..track_title = json['track_title'] as String
    ..track_tags = json['track_tags'] as String
    ..track_intro = json['track_intro'] as String
    ..cover_url_small = json['cover_url_small'] as String
    ..cover_url_middle = json['cover_url_middle'] as String
    ..cover_url_large = json['cover_url_large'] as String
    ..announcer = json['announcer'] == null
        ? null
        : Announcer.fromJson(json['announcer'] as Map<String, dynamic>)
    ..duration = json['duration'] as num
    ..play_count = json['play_count'] as num
    ..favorite_count = json['favorite_count'] as num
    ..comment_count = json['comment_count'] as num
    ..download_count = json['download_count'] as num
    ..play_size_32 = json['play_size_32'] as num
    ..play_size_64 = json['play_size_64'] as num
    ..play_size_64_m4a = json['play_size_64_m4a'] as num
    ..play_size_24_m4a = json['play_size_24_m4a'] as num
    ..play_size_amr = json['play_size_amr'] as num
    ..can_download = json['can_download'] as bool
    ..download_size = json['download_size'] as num
    ..subordinated_album = json['subordinated_album'] == null
        ? null
        : SubordinatedAlbum.fromJson(
            json['subordinated_album'] as Map<String, dynamic>)
    ..source = json['source'] as num
    ..updated_at = json['updated_at'] as num
    ..created_at = json['created_at'] as num
    ..order_num = json['order_num'] as num;
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'category_id': instance.category_id,
      'track_title': instance.track_title,
      'track_tags': instance.track_tags,
      'track_intro': instance.track_intro,
      'cover_url_small': instance.cover_url_small,
      'cover_url_middle': instance.cover_url_middle,
      'cover_url_large': instance.cover_url_large,
      'announcer': instance.announcer,
      'duration': instance.duration,
      'play_count': instance.play_count,
      'favorite_count': instance.favorite_count,
      'comment_count': instance.comment_count,
      'download_count': instance.download_count,
      'play_size_32': instance.play_size_32,
      'play_size_64': instance.play_size_64,
      'play_size_64_m4a': instance.play_size_64_m4a,
      'play_size_24_m4a': instance.play_size_24_m4a,
      'play_size_amr': instance.play_size_amr,
      'can_download': instance.can_download,
      'download_size': instance.download_size,
      'subordinated_album': instance.subordinated_album,
      'source': instance.source,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'order_num': instance.order_num
    };
