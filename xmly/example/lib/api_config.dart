class ApiConfig {
  static const API = "http:api.ximalaya.com/";

  ///多筛选条件搜索焦点图
  static const GET_BANNERS = "${API}operation/banners";

  ///多筛选条件搜索听单
  static const GET_COLUMNS = "${API}operation/columns";

  ///批量获取听单信息
  static const GET_COLUMNS_BATCH = "${API}operation/batch_get_columns";

  ///分页获取听单内容
  static const GET_COLUMN_CONTENT = "${API}operation/browse_column_content";

  ///获取开发者收藏专辑(搜索专辑)
  static const GET_DEVELOPER_COLLECTED_ALBUMS =
      "${API}operation/developer_collected_albums";

  ///多筛选条件搜索专辑
  static const GET_SEARCHED_ALBUMS = "${API}v2/search/albums";

  ///专辑浏览
  static const GET_TRACKS = "${API}albums/browse";

  ///多筛选条件搜索声音
  static const GET_SEARCH_TRACKS = "${API}v2/search/tracks";

  ///获取某条声音在专辑内所属声音页信息列表
  static const GET_LAST_PLAY_TRACKS = "${API}tracks/get_last_play_tracks";

  ///批量获取专辑信息
  static const GET_ALBUMS_BATCH = "${API}albums/get_batch";
}
