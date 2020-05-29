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
    ..avatar_url = json['avatar_url'] as String
    ..is_verified = json['is_verified'] as bool
    ..anchor_grade = json['anchor_grade'] as num;
}

Map<String, dynamic> _$AnnouncerToJson(Announcer instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'nickname': instance.nickname,
      'avatar_url': instance.avatar_url,
      'is_verified': instance.is_verified,
      'anchor_grade': instance.anchor_grade
    };
