// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcer _$AnnouncerFromJson(Map<String, dynamic> json) {
  return Announcer()
    ..id = json['id'] as num
    ..kind = json['kind'] as String
    ..nickname = json['nickname'] as String
    ..avatarUrl = json['avatar_url'] as String
    ..isVerified = json['is_verified'] as bool
    ..anchorGrade = json['anchor_grade'] as int;
}

Map<String, dynamic> _$AnnouncerToJson(Announcer instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'nickname': instance.nickname,
      'avatar_url': instance.avatarUrl,
      'is_verified': instance.isVerified,
      'anchor_grade': instance.anchorGrade
    };
