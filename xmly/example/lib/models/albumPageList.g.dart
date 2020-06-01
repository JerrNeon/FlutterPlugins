// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumPageList _$AlbumPageListFromJson(Map<String, dynamic> json) {
  return AlbumPageList()
    ..categoryId = json['category_id'] as int
    ..totalPage = json['total_page'] as int
    ..totalCount = json['total_count'] as int
    ..currentPage = json['current_page'] as int
    ..albums = (json['albums'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AlbumPageListToJson(AlbumPageList instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'total_page': instance.totalPage,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'albums': instance.albums
    };
