import 'package:wan/model/homebanner.dart';
import 'package:wan/model/homedata.dart';
import 'package:dio/dio.dart';
import 'package:wan/model/hotkey.dart';
import 'package:wan/model/navi.dart';
import 'package:wan/net/api.dart';
import 'package:wan/net/interceptor.dart';
import 'package:wan/net/request.dart';

///请求
class RequestImpl extends Request {
  Dio _dio;

  RequestImpl() : super.internal() {
    Options options = Options(baseUrl: Api.baseUrl, connectTimeout: 10000);
    _dio = Dio(options);
    LogInterceptor interceptor = LogInterceptor();
    _dio.interceptor.request.onSend = interceptor.onSend;
    _dio.interceptor.response.onSuccess = interceptor.onSuccess;
    _dio.interceptor.response.onError = interceptor.onError;
  }

  //获取首页列表
  @override
  Future<HomeData> getHomeList(int page) async {
    String reqAPi = '${Api.homelist}$page/json';
    Response response = await _dio.get(reqAPi);
    return HomeData.fromJson(response.data);
  }

  //获取banner
  @override
  Future<HomeBanner> getHomeBanner() async {
    Response response = await _dio.get(Api.homebanner);
    return HomeBanner.fromJson(response.data);
  }

  //获取导航数据
  @override
  Future<Navi> getNavi() async {
    Response response = await _dio.get(Api.navi);
    return Navi.fromJson(response.data);
  }

  //获取搜索热词
  @override
  Future<HotKey> getHotKey() async {
    Response response = await _dio.get(Api.hotkey);
    return HotKey.fromJson(response.data);
  }

  //搜索
  @override
  Future<HomeData> search(int page, String keyword) async {
    Response response = await _dio.post('${Api.search}$page/json',
        data: FormData.from({'k': keyword}));
    return HomeData.fromJson(response.data);
  }
}
