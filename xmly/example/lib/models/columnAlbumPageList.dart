import 'package:json_annotation/json_annotation.dart';
import "album.dart";
part 'columnAlbumPageList.g.dart';

@JsonSerializable()
class ColumnAlbumPageList {
  ColumnAlbumPageList();

  @JsonKey(name: 'total_page')
  int totalPage;
  @JsonKey(name: 'total_count')
  int totalCount;
  @JsonKey(name: 'current_page')
  int currentPage;
  @JsonKey(name: 'content_type')
  int contentType;
  List<Album> values;

  factory ColumnAlbumPageList.fromJson(Map<String, dynamic> json) =>
      _$ColumnAlbumPageListFromJson(json);
  Map<String, dynamic> toJson() => _$ColumnAlbumPageListToJson(this);
}
