import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';

class OptionButton extends StatefulWidget {
  OptionButton({super.key, required this.text, required this.onPressed, required this.isSelected});

  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 30,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              minimumSize: const WidgetStatePropertyAll(Size(0, 30)),
              maximumSize: WidgetStatePropertyAll(Size(300, 30)),
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(widget.isSelected ? MyColors.optionSelectedColor : MyColors.systemGray6),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
          child: Text(widget.text,
              style: TextStyle(color: widget.isSelected ? Colors.white : Colors.black, fontSize: 14))),
    );
  }
}
