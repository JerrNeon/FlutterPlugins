import 'package:json_annotation/json_annotation.dart';
import "album.dart";
part 'albumPageList.g.dart';

@JsonSerializable()
class AlbumPageList {
  AlbumPageList();

  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'total_page')
  int totalPage;
  @JsonKey(name: 'total_count')
  int totalCount;
  @JsonKey(name: 'current_page')
  int currentPage;
  List<Album> albums;

  factory AlbumPageList.fromJson(Map<String, dynamic> json) =>
      _$AlbumPageListFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumPageListToJson(this);
}
