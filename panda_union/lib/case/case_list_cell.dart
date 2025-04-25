import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/image_loader.dart';
import 'package:panda_union/common/tag_chip.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/models/case.dart';

class CaseListCell extends StatefulWidget {
  CaseListCell({super.key, required this.data});

  final Case data;

  @override
  _CaseListCellState createState() => _CaseListCellState();
}

class _CaseListCellState extends State<CaseListCell> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CaseListCell oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildTags() {
    List<TagChip> tags = [
      if (widget.data.getProcessStatusName().isNotEmpty)
        TagChip(
          text: widget.data.getProcessStatusName(),
          bgColor: widget.data.getProcessStatusColor(),
        ),
      if (widget.data.isCover())
        TagChip(
          text: "Cover",
          textColor: Colors.orange,
          bgColor: MyColors.coverCaseColor,
          borderColor: Colors.orange,
        ),
      TagChip(text: widget.data.getTypeName()),
      TagChip(text: widget.data.getRoleName()),
      TagChip(text: widget.data.getFormat().toUpperCase()),
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

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 5),
      color: widget.data.isExpired() ? MyColors.systemGray6 : Colors.white,
      child: Stack(
        children: [Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.getPatientNameAndOrgName(),
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      SizedBox(height: 4),
                      _buildTags(),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(localDateDesByISO(widget.data.editDate),
                              style: TextStyle(
                                  fontSize: 14, color: MyColors.systemGray)),
                          SizedBox(width: 8),
                          Image.asset(
                            "images/downloaded.png",
                            width: 22,
                            height: 22,
                            color: widget.data.downloadStatus == 1
                                ? MyColors.downloadedCaseColor
                                : MyColors.systemGray5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    "images/${widget.data.getTypeImageName()}",
                    width: 36,
                    height: 36,
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: MyColors.systemGray5,
              margin: EdgeInsets.only(top: 8),
            )
          ],
        ),
        if(widget.data.isExpired())
          Positioned(
            top: 15,
            right: -55,
            child: Transform.rotate(
              angle: 0.8,
              child: Container(
                width: 150,
                padding: EdgeInsets.all(0),
                color: Colors.orange[700],
                child: Text(
                  "Expired",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
