import 'package:flutter/material.dart';

class MyChip extends StatefulWidget {
  MyChip({super.key, required this.text, this.textStyle, this.bgColor, this.selectedColor});

  String text;
  TextStyle? textStyle;
  Color? bgColor;
  Color? selectedColor;

  @override
  _MyChipState createState() {
    return _MyChipState();
  }
}

class _MyChipState extends State<MyChip> {
  bool _selected = false;

  void handleTap() {
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.textStyle = TextStyle(color: Colors.black);
    widget.bgColor = Colors.grey[200];
    widget.selectedColor = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: handleTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 6, right: 10, bottom: 6),
          color: _selected? widget.selectedColor:widget.bgColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.text, style: widget.textStyle),
            ],
          ),
        ),
      ),
    );
  }

}