import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatelessWidget {
  const StreamBuilderDemo({super.key, required this.title});

  final String title;

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 3), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder(
            stream: counter(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("No stream");
                case ConnectionState.waiting:
                  return Text("Waiting...");
                case ConnectionState.active:
                  return Text('active: ${snapshot.data}');
                case ConnectionState.done:
                  return Text("Stream stopped");
                default:
                  return Text("Unknown state");
              }
            }),
      ),
    );
  }
}
