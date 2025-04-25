import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/image_loader.dart';
import 'package:panda_union/common/tag_chip.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/models/case.dart';

class CaseCardCell extends StatefulWidget {
  CaseCardCell(
      {super.key,
      required this.data,
      required this.localCaseImagePath,
      required this.callback});

  final Case data;
  final String localCaseImagePath;
  ImageLoaderCallback callback;

  @override
  _CaseCardCellState createState() => _CaseCardCellState();
}

class _CaseCardCellState extends State<CaseCardCell> {
  late String _localCaseImagePath;
  final String _placeholderImagePath = "images/case_default.png";
  String? _pendingPrecachePath;

  @override
  void initState() {
    super.initState();

    _localCaseImagePath = widget.localCaseImagePath;

    if (isEmptyOrNull(_localCaseImagePath)) {
      downloadImage();
    } else {
      //_loadFileImageWithPrecache(_localCaseImagePath); //延后到didChangeDependencies再预加载,否则会crash
      _pendingPrecachePath = _localCaseImagePath;
    }
  }

  @override
  void didUpdateWidget(covariant CaseCardCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.localCaseImagePath != oldWidget.localCaseImagePath &&
        File(widget.localCaseImagePath).existsSync()) {
      _loadFileImageWithPrecache(widget.localCaseImagePath);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 预加载默认图
    precacheImage(
      AssetImage(_placeholderImagePath),
      context,
    );

    // 延迟预加载 FileImage
    if (!isEmptyOrNull(_pendingPrecachePath)) {
      _loadFileImageWithPrecache(_pendingPrecachePath!);
      _pendingPrecachePath = null;
    }
  }

  void _loadFileImageWithPrecache(String path) {
    final fileImage = FileImage(File(path));
    final config = createLocalImageConfiguration(context);
    fileImage.resolve(config).addListener(
          ImageStreamListener(
            (ImageInfo imageInfo, bool synchronousCall) {
              if (mounted) {
                setState(() {
                  _localCaseImagePath = path;
                });
              }
            },
            onError: (error, stackTrace) {
              debugPrint("File image load error: $error");
              if (mounted) {
                setState(() {
                  _localCaseImagePath = ""; // 强制回退到 placeholder
                });
              }
            },
          ),
        );
  }

  Future<void> downloadImage() async {
    debugPrint("#### downloadImage: ${widget.data.id}");

    ImageLoader.instance.loadCaseImageById(
      widget.data.id,
      (savePath, token) {
        if (savePath != null && mounted) {
          if (token != null) {
            if (token.containsKey("case_id")) {
              String caseId = token["case_id"];

              if (caseId == widget.data.id) {
                debugPrint("#### loadedImage: $caseId, $savePath");
                _loadFileImageWithPrecache(savePath);
              } else {
                debugPrint("#### loadedImage: $caseId, $savePath, not match");
                widget.callback(savePath, token);
              }
            }
          }
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
    final hasImage = !isEmptyOrNull(_localCaseImagePath);
    var placeholderImage = Image.asset(
      _placeholderImagePath,
      width: 110,
      height: 110,
      color: MyColors.systemGray4,
    );

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 5),
      color: widget.data.isExpired() ? MyColors.systemGray6 : Colors.white,
      child: Stack(
        children: [Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                hasImage
                    ? FadeInImage(
                        placeholder: AssetImage(_placeholderImagePath),
                        image: FileImage(File(_localCaseImagePath)),
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 150),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return placeholderImage;
                        },
                      )
                    : placeholderImage,
                SizedBox(width: 8),
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
                      Row(
                        children: [
                          Text(localDateDesByISO(widget.data.editDate),
                              style: TextStyle(
                                  fontSize: 14, color: MyColors.systemGray)),
                          SizedBox(width: 8),
                          Image.asset(
                            "images/downloaded.png",
                            width: 26,
                            height: 26,
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
            top: 20,
            right: -50,
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
