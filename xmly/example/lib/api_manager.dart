import 'package:xmly/xmly_index.dart';
import 'package:xmly_example/api_config.dart';

class ApiManager {
  factory ApiManager() => _getInstacne();

  static ApiManager _instance;

  ApiManager._();

  static ApiManager _getInstacne() {
    if (_instance == null) {
      _instance = ApiManager._();
    }
    return _instance;
  }

  ///多筛选条件搜索听单
  Future<String> getBannerList({
    int bannerContentType =
        2, //	Int	否	焦点图类型 0-不限 1-单个用户 2-单个专辑，3-单个声音，4-链接，9-听单，默认值为0
    int scope = 2, //	Long	否	查询范围 0-全部，1-喜马焦点图，2-开发者自运营焦点图，默认为0
    int isPaid = 0, //	Int	否	是否付费： 1：付费 ，0：免费 ，-1：不限
    String sortBy =
        "updated_at", //	String	否	排序字段 可选值：created_at、update_at 默认值：updated_at
    String sort = "desc", //	String	否	desc-降序排列 asc-升序排列 默认值：desc
    int page = 1, //	Int	否	返回第几页，从1开始，默认为1
    int count = 20, //	Int	否	每页大小，范围为[1,200]，默认为20
  }) {
    return Xmly().baseGetRequest(url: ApiConfig.GET_BANNERS, params: {
      "banner_content_type": bannerContentType.toString(),
      "scope": scope.toString(),
      "is_paid": isPaid.toString(),
      "sort_by": sortBy,
      "sort": sort,
      "page": page.toString(),
      "count": count.toString(),
    });
  }
}
