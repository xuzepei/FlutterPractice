import 'package:flutter/material.dart';
import 'package:panda_union/common/custom.dart';

class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {

  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      // setState(() {
      //   // Adjust opacity based on scroll position
      //   _opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      // });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustom.buildAppBar("Case Management", _opacity, context, null, true),
      body: SafeArea(child: SingleChildScrollView(
        controller: _scrollController,
        child: null,)),
    );
  }
}
