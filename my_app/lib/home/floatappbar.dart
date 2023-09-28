import 'package:flutter/material.dart';

class FloatAppBarPage extends StatelessWidget {
  final String title;

  const FloatAppBarPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Text(title),
        floating: true,
        flexibleSpace: Placeholder(),
        expandedHeight: 50,
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('Item #$index')),
              childCount: 1000))
    ]));
  }
}
