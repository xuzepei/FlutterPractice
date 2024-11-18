import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollControllerDemo extends StatefulWidget {
  ScrollControllerDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScrollControllerDemoState();
  }
}

class ScrollControllerDemoState extends State<ScrollControllerDemo> {
  var _listData = <String>[];
  var _isRequesting = false;
  var _isLoadingMore = false;
  var _needToIndicator = true;
  var _currentPage = 0;
  var _isUserScrolling = false;
  var _showBackToTopBtn = false;
  double _progress = 0;
  var _progressText = "";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //通过ScrollController监听滚动到底部
    _scrollController.addListener(() {
      var currentScroll = _scrollController.position.pixels;
      var maxScroll = _scrollController.position.maxScrollExtent;
      var offset = _scrollController.offset;
      debugPrint("####: currentScroll: $currentScroll");
      debugPrint("####: maxScroll: $maxScroll");
      debugPrint("####: offset: $offset");

      //超过1000像素显示返回顶部按钮
      if (currentScroll > 3000 && _showBackToTopBtn == false) {
        setState(() {
          _showBackToTopBtn = true;
        });
      } else if (currentScroll <= 1000 && _showBackToTopBtn == true) {
        setState(() {
          _showBackToTopBtn = false;
        });
      }

      if (maxScroll == currentScroll && !_isLoadingMore) {
        debugPrint(
            "####: scroll to the bottom. _isUserScrolling: $_isUserScrolling");
        if (_isUserScrolling) {
          loadMore(true);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if(notification.metrics.maxScrollExtent > 0) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;

            setState(() {
              _progress = progress;
              _progressText = _progress.isNaN ? "":"${(_progress * 100).toInt()}%";
            });
          }

          return false;
          //return true; //放开此行注释后，进度条将失效
        },
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () {
                return requestData(false);
              },
              child: ListView.separated(
                  controller: _scrollController,
                  // 绑定 ScrollController
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < _listData.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(_listData[index],
                              textScaler: TextScaler.linear(1.5)),
                          onTap: () {
                            debugPrint("####: onTapListItemIndex: $index");
                          },
                        ),
                      );
                    } else if (_isLoadingMore) {
                      return Container(
                        height: 40,
                        color: Colors.yellow,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Divider(height: 0, color: Colors.grey[200]),
                    );
                  },
                  itemCount: _listData.length + 1),
            ),
            if (_isRequesting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  alignment: Alignment.center,
                  child: _needToIndicator
                      ? CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 2.0,
                        )
                      : null,
                ),
              ),
            Center(
              child: _progress == 0 ? null:CircleAvatar(
                radius: 20.0,
                child: Text(_progressText, textScaler: TextScaler.linear(0.7),),
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopBtn
          ? FloatingActionButton.small(
              onPressed: () {
                //返回到顶部动画
                _scrollController.animateTo(0,
                    duration: Duration(microseconds: 300), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  void scrollToBottom() {
    // 延迟滚动以确保新数据已被渲染
    _isUserScrolling = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      Future.delayed(Duration(milliseconds: 500), () {
        _isUserScrolling = true;
      });
    });
  }

  Future<void> requestData(bool needToShowIndicator) async {
    if (_isRequesting || _isLoadingMore) {
      return;
    }

    debugPrint("####: requestData");

    setState(() {
      _needToIndicator = needToShowIndicator;
      _isRequesting = true;
    });
    await Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _currentPage = 0;
        _listData.clear();
        for (int i = 1; i <= 20; i++) {
          _listData.add(i.toString());
        }

        _isRequesting = false;
        _needToIndicator = true;

        scrollToBottom();
      });
    });
  }

  Future<void> loadMore(bool needToShowIndicator) async {
    if (_isRequesting || _isLoadingMore) {
      return;
    }

    debugPrint("####: loadMore");

    setState(() {
      _needToIndicator = needToShowIndicator;
      _isLoadingMore = true;
    });

    await Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _currentPage++;
        for (int i = 1; i <= 20; i++) {
          var value = _currentPage * 20 + i;
          _listData.add(value.toString());
        }

        _isLoadingMore = false;
        _needToIndicator = true;

        scrollToBottom();
      });
    });
  }
}
