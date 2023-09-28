import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'locations.dart';

class LocationListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey backgroundImageKey = GlobalKey();

  LocationListItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.country});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(children: [
                  buildParallaxBackground(context),
                  Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                          
                          Padding(padding: EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            country,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          
                        ]),

                ]))));
  }

  Widget buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class ParallaxRecipe extends StatelessWidget {
  final String title;

  const ParallaxRecipe({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
          child: Column(
        children: [
          for (final location in locations)
            LocationListItem(
                country: location.place,
                imageUrl: location.imageUrl,
                name: location.name)
        ],
      )),
    );
  }
}
