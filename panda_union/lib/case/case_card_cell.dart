import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/image_loader.dart';
import 'package:panda_union/common/tag_chip.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/models/case.dart';

class CaseCardCell extends StatefulWidget {
  CaseCardCell({super.key, required this.data, required this.localCaseImagePath});

  final Case data;
  String localCaseImagePath;

  @override
  _CaseCardCellState createState() => _CaseCardCellState();
}

class _CaseCardCellState extends State<CaseCardCell> {
  

  @override
  void initState() {
    super.initState();

    downloadImage();
  }

  Future<void> downloadImage() async {
    ImageLoader.instance.loadCaseImageById(
      widget.data.id,
      (savePath) {
        if (savePath != null) {
          setState(() {
            widget.localCaseImagePath = savePath;
          });


        }
      },
    );
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
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              (isEmptyOrNull(widget.localCaseImagePath)) ? Image.asset(
                "images/case_default.png",
                width: 110,
                height: 110,
                color: MyColors.systemGray4,
              ) : Image.file(
                File(widget.localCaseImagePath),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.orgName,
                        style: TextStyle(fontSize: 17, color: Colors.black)),
                    SizedBox(height: 2),
                    Text(
                      widget.data.patientName,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    _buildTags(),
                    SizedBox(height: 4),
                    Text(localDateDesByISO(widget.data.editDate),
                        style: TextStyle(
                            fontSize: 14, color: MyColors.systemGray)),
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
    );
  }
}
