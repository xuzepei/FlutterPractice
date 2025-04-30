import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/common/indicators.dart';
import 'package:panda_union/common/tag_chip.dart';
import 'package:panda_union/models/case.dart';

class CaseDetailPage extends StatefulWidget {
  const CaseDetailPage({super.key, required this.myCase});
  final Case myCase;

  @override
  _CaseDetailPageState createState() => _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage> {

  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;
  var _isRequesting = false;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      setState(() {
        // Adjust opacity based on scroll position
        //_opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      });
    });
  }

    Widget _buildTags() {
    List<TagChip> tags = [
      if (widget.myCase.isCover())
        TagChip(
          text: "Cover",
          textColor: Colors.orange,
          bgColor: MyColors.coverCaseColor,
          borderColor: Colors.orange,
        ),
      TagChip(text: widget.myCase.getTypeName()),
      TagChip(text: widget.myCase.getRoleName()),
      TagChip(text: widget.myCase.getFormat().toUpperCase()),
    ].where((tag) => tag.text.isNotEmpty).toList(); // 过滤空字符串，避免创建无效组件

    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.0, //主轴(水平)方向间距
      runSpacing: 4.0, //纵轴（垂直）方向间距
      children: tags,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: MyColors.systemGray6,
          appBar: MyCustom.buildAppBar("Case Detail", _opacity, context),
          body: SafeArea(
            child: Container(
              constraints: BoxConstraints.expand(), // 强制填满屏幕
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ), child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.myCase.orgName,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,),
                                  ),
                                  SizedBox(height: 4),
                                  _buildTags(),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                                      "images/${widget.myCase.getTypeImageName()}",
                                                      width: 36,
                                                      height: 36,
                                                    ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_isRequesting)
          Indicator.buildCircleIndicator(),
      ],
    );
  }
}