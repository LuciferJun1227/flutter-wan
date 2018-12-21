import 'package:flutter/material.dart';
import 'package:wan/conf/constant.dart';
import 'package:wan/page/login.dart';
import 'package:wan/themes.dart';
import 'package:wan/utils/sputils.dart';
import 'package:wan/utils/toastutils.dart';
import 'package:wan/event/event.dart';

///我的
class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MineState();
  }
}

class _MineState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Mine();
  }
}

class _Mine extends State<_MineState> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  void _getTheme() async {
    SpUtils.getBool(Constant.spDarkTheme).then((bool) {
      _switchValue = bool;
      setState(() {});
    });
  }

  void _setTheme(bool dark) async {
    SpUtils.getInt(Constant.spCurTheme).then((int) {
      _switchValue = dark;
      setState(() {
        SpUtils.setBool(Constant.spDarkTheme, dark);
        bus.fire(new ThemeEvent(int, dark));
      });
    });
  }

  _buildThemesDialogItems() {
    return themes
        .map((t) => SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: t.data.primaryColor,
                    radius: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(t.name)
                ],
              ),
              onPressed: () {
                Navigator.pop(context, themes.indexOf(t));
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Center(
              child: GestureDetector(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/avatar.png',
                  width: 80,
                ),
                Text('未登录')
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )),
          margin: EdgeInsets.only(top: 40, bottom: 20),
        ),
        Divider(), //分割线
        Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/ic_theme.png',
                  color: Theme.of(context).primaryColorLight,
                  width: 25,
                ),
                margin: EdgeInsets.only(left: 15),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            title: Text('选择主题'),
                            children: _buildThemesDialogItems(),
                          )).then((value) {
                    if (value != null) {
                      SpUtils.setBool(Constant.spDarkTheme, false).then((v) {
                        SpUtils.setInt(Constant.spCurTheme, value).then((v) {
                          bus.fire(new ThemeEvent(value, false));
                        });
                      });
                    }
                  });
                },
                child: Container(
                  child: Text(
                    '选择主题',
                    style: TextStyle(fontSize: 16),
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
              ),
              Expanded(
                  child: Container(
                child: Row(
//                    alignment: Alignment.bottomRight,
                  //switch控件
                  children: <Widget>[
                    Text(
                      '夜间模式',
                      style: TextStyle(fontSize: 12),
                    ),
                    Switch.adaptive(
                        value: _switchValue,
                        onChanged: (bool) {
                          _setTheme(bool);
                        }),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              )),
            ],
          ),
          height: 40,
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            ToastUtils.showShort('收藏');
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/ic_favorite.png',
                    color: Theme.of(context).primaryColorLight,
                    width: 25,
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '收藏',
                      style: TextStyle(fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 5),
                  ),
//                  margin: EdgeInsets.only(left: 5),
                ),
              ],
            ),
            height: 40,
          ),
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            ToastUtils.showShort('TODO');
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/ic_todo.png',
                    color: Theme.of(context).primaryColorLight,
                    width: 25,
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'TODO',
                      style: TextStyle(fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 5),
                  ),
//                  margin: EdgeInsets.only(left: 5),
                ),
              ],
            ),
            height: 40,
          ),
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            ToastUtils.showShort('设置');
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/ic_setting.png',
                    color: Theme.of(context).primaryColorLight,
                    width: 25,
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '设置',
                      style: TextStyle(fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 5),
                  ),
//                  margin: EdgeInsets.only(left: 5),
                ),
              ],
            ),
            height: 40,
          ),
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            ToastUtils.showShort('关于');
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/ic_about.png',
                    color: Theme.of(context).primaryColorLight,
                    width: 25,
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '关于',
                      style: TextStyle(fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 5),
                  ),
//                  margin: EdgeInsets.only(left: 5),
                ),
              ],
            ),
            height: 40,
          ),
        ),
        Divider(),
      ],
    );
  }
}
