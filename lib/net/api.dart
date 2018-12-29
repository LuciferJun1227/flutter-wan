///接口地址
class Api {
  //Base
  static String baseUrl = 'http://www.wanandroid.com/';

  //首页列表
  static String homelist = 'article/list/';

  //首页banner
  static String homebanner = 'banner/json/';

  //导航
  static String navi = 'navi/json';

  //搜索热词
  static String hotkey = '/hotkey/json';

  //搜索
  static String search = 'article/query/';

  //公众号列表
  static String subscriptions = 'wxarticle/chapters/json';

  //查看某个公众号历史数据
  static String subscriptionsHis = 'wxarticle/list/';

  //登录
  static String login = 'user/login';

  //登出
  static String logout = 'user/logout/json';

  //收藏文章列表
  static String favoriteList = 'lg/collect/list/';

  //收藏
  static String favorite = 'lg/collect/';

  //取消收藏
  static String favoriteCancel = 'lg/uncollect_originId/';
}
