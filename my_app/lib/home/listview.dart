import 'package:flutter/material.dart';

class HeadingItem extends StatelessWidget{
  final String text;

  const HeadingItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(text, style: Theme.of(context).textTheme.headlineSmall),
        ],
    );
  }
}

class MessageItem extends StatelessWidget {
  final String sender;
  final String text;

  const MessageItem({super.key, required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(sender, style: Theme.of(context).textTheme.titleMedium),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
    );
  }
}

class ListViewTest extends StatelessWidget {
  ListViewTest({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    var items = List.generate(
        1000,
        (i) => i % 10 == 0
            ? HeadingItem(text: 'Heading $i')
            : MessageItem(sender: 'Sender $i', text: 'Message body $i')
      );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
