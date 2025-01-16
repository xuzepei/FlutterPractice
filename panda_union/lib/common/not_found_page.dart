import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  final String message = "Page not found";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
        centerTitle: true,
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
