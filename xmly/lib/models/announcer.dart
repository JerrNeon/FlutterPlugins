import 'package:json_annotation/json_annotation.dart';

part 'announcer.g.dart';

@JsonSerializable()
class Announcer {
    Announcer();

    num id;
    String kind;
    String nickname;
    @JsonKey(name : 'avatar_url') String avatarUrl;
    @JsonKey(name : 'is_verified') bool isVerified;
    @JsonKey(name : 'anchor_grade') int anchorGrade;
    
    factory Announcer.fromJson(Map<String,dynamic> json) => _$AnnouncerFromJson(json);
    Map<String, dynamic> toJson() => _$AnnouncerToJson(this);
}
