import 'package:flutter/material.dart';
import 'package:wan/model/navi_dto.dart';
import 'package:wan/model/vo/flowitem_vo.dart';
import 'package:wan/net/request.dart';
import 'package:wan/page/article.dart';
import 'package:wan/page/search.dart';
import 'package:wan/widget/flowitems.dart';
import 'package:wan/widget/loading.dart';

///导航
class NaviPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NaviWidget();
  }
}

class _NaviWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NaviState();
  }
}

class _NaviState extends State<_NaviWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TabController _controller;

  List<Tab> _tabs = List();
  List<FlowItemsWidget> _tabpages = List();
  FlowItemsWidget _selectedPage;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    return Request().getNavi().then((data) {
      Navi navi = data;
      _controller = TabController(length: navi.data.length, vsync: this);
      _tabs = navi.data
          .map<Tab>((Data d) => Tab(
                text: d.name,
              ))
          .toList();
      _tabpages = navi.data
          .map<FlowItemsWidget>((Data d) => FlowItemsWidget(
              items: d.articles
                  .map((a) => FlowItemVO(a.id, a.title, a.link))
                  .toList(),
              onPress: (item) {
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (context) {
                  return ArticlePage(item.link);
                }));
              }))
          .toList();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('WanFlutter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          // Loading
          child: Loading(),
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('WanFlutter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: _tabs,
            controller: _controller,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: _tabpages,
          controller: _controller,
        ),
      );
    }
  }
}
