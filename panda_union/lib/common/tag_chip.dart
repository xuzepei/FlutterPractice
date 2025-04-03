import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';

class TagChip extends StatefulWidget {
  TagChip(
      {super.key,
      required this.text,
      this.textColor = Colors.black,
      this.bgColor = MyColors.systemGray5,
      this.borderColor = Colors.transparent});

  String text;
  Color? textColor;
  Color? bgColor;
  Color? borderColor;

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  bool _selected = false;

  void handleTap() {

    debugPrint("#### TagChip tapped: ${widget.text}");

    // Toggle the selected state
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(
              color: widget.borderColor!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.text, style: TextStyle(
                fontSize: 13,
                color: widget.textColor,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
