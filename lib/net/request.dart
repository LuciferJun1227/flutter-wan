import 'package:wan/model/homebanner_dto.dart';
import 'package:wan/model/articledatas_dto.dart';
import 'package:wan/model/hotkey_dto.dart';
import 'package:wan/model/navi_dto.dart';
import 'package:wan/net/requestimpl.dart';

abstract class Request {
  static RequestImpl _impl;

  Request.internal();

  factory Request() {
    if (_impl == null) {
      _impl = RequestImpl();
    }
    return _impl;
  }

  //获取首页列表
  Future<ArticleDatasDTO> getHomeList(int index);

  //获取banner
  Future<HomeBannerDTO> getHomeBanner();

  //获取导航数据
  Future<Navi> getNavi();

  //获取搜索热词
  Future<HotKeyDTO> getHotKey();

  //搜索
  Future<ArticleDatasDTO> search(int page, String keyword);
}
