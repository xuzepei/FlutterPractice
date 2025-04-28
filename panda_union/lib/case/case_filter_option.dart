import 'package:flutter/material.dart';
import 'package:panda_union/case/option_buttton.dart';

class CaseFilterOption extends StatefulWidget {
  const CaseFilterOption({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
    this.isSingleSelect = false,
  });

  final String title;
  final List<Map<String, String>> options;
  final List<String> selectedOptions; // 父组件传递的选中状态
  final ValueChanged<List<String>> onChanged;
  final bool isSingleSelect;

  @override
  _CaseFilterOptionState createState() => _CaseFilterOptionState();
}

class _CaseFilterOptionState extends State<CaseFilterOption> {
  bool _isSelectedAll = true;
  List<String> _tempSelectedOptions = [];

  @override
  void initState() {
    super.initState();

      _tempSelectedOptions = widget.selectedOptions;
      if (_tempSelectedOptions.isEmpty) {
        _isSelectedAll = true;
      } else {
        _isSelectedAll = false;
      }
  }

  // @override
  void didUpdateWidget(covariant CaseFilterOption oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果父组件的 selectedOptions 更新，更新临时选中状态
    if (oldWidget.selectedOptions != widget.selectedOptions) {
      _tempSelectedOptions = widget.selectedOptions;
    }

    if (_tempSelectedOptions.isEmpty) {
      _isSelectedAll = true;
    } else {
      _isSelectedAll = false;
    }
  }

  void onTappedOption(int index) {
    if (index == 0) {
      setState(() {
        _isSelectedAll = !_isSelectedAll;
        _tempSelectedOptions.clear();
      });
    } else {
      setState(() {
        if (widget.isSingleSelect) {
          _isSelectedAll = false;
          String selectedValue = widget.options[index - 1]["value"]!;
          _tempSelectedOptions.clear();
          _tempSelectedOptions.add(selectedValue);
        } else {
          _isSelectedAll = false;
          String selectedValue = widget.options[index - 1]["value"]!;
          if (_tempSelectedOptions.contains(selectedValue)) {
            _tempSelectedOptions.remove(selectedValue);

            if (_tempSelectedOptions.isEmpty) {
              _isSelectedAll = true;
            }
          } else {
            _tempSelectedOptions.add(selectedValue);
          }
        }
      });
    }

    widget.onChanged(_tempSelectedOptions);
  }

  Widget _buildOptionButtons() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 8.0, //主轴(水平)方向间距
      runSpacing: 8.0, //纵轴（垂直）方向间距
      children: List.generate(widget.options.length, (index) {
        return OptionButton(
          text: widget.options[index]["name"]!,
          onPressed: () => onTappedOption(index + 1),
          isSelected:
              _tempSelectedOptions.contains(widget.options[index]["value"]!),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          OptionButton(
              text: "All",
              onPressed: () => onTappedOption(0),
              isSelected: _isSelectedAll),
          SizedBox(height: 8),
          _buildOptionButtons(),
        ],
      ),
    );
  }
}
