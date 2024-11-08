import 'package:flutter/material.dart';

class SingleLineFittedBox extends StatelessWidget {
  SingleLineFittedBox({super.key, this.child});

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return FittedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: double.infinity),
          child: child,
        ),
      );
    });
  }
}
