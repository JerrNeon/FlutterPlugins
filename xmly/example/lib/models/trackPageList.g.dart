// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trackPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackPageList _$TrackPageListFromJson(Map<String, dynamic> json) {
  return TrackPageList()
    ..albumId = json['album_id'] as int
    ..totalPage = json['total_page'] as int
    ..totalCount = json['total_count'] as int
    ..currentPage = json['current_page'] as int
    ..albumTitle = json['album_title'] as String
    ..albumIntro = json['album_intro'] as String
    ..categoryId = json['category_id'] as int
    ..coverUrlSmall = json['cover_url_small'] as String
    ..coverUrlMiddle = json['cover_url_middle'] as String
    ..coverUrlLarge = json['cover_url_large'] as String
    ..canDownload = json['can_download'] as bool
    ..tracks = (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TrackPageListToJson(TrackPageList instance) =>
    <String, dynamic>{
      'album_id': instance.albumId,
      'total_page': instance.totalPage,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'album_title': instance.albumTitle,
      'album_intro': instance.albumIntro,
      'category_id': instance.categoryId,
      'cover_url_small': instance.coverUrlSmall,
      'cover_url_middle': instance.coverUrlMiddle,
      'cover_url_large': instance.coverUrlLarge,
      'can_download': instance.canDownload,
      'tracks': instance.tracks
    };
