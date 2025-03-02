import 'package:flutter/material.dart';
import 'package:panda_union/common/custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final ScrollController _scrollController = ScrollController();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      setState(() {
        // Adjust opacity based on scroll position
        _opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      });
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
      appBar: MyCustom.buildAppBar("Register", _opacity, context),
      body: SafeArea(child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(child: Text("Register Page", style: TextStyle(fontSize: 30),)),)),
    );
  }
}
