import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({super.key, required this.child, this.needToKeep = true});

  final bool needToKeep;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KeepAliveWrapperState();
  }
}

class KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.needToKeep;

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.needToKeep != widget.needToKeep) {
      updateKeepAlive();
    }

    super.didUpdateWidget(oldWidget);
  }
}
