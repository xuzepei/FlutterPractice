
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/util/color.dart';

class AnimatedTickIndicator extends StatefulWidget {
  AnimatedTickIndicator({super.key, required this.text, this.onComplete});

  String text;
  VoidCallback? onComplete;

  @override
  State<AnimatedTickIndicator> createState() => _AnimatedTickIndicatorState();
}

class _AnimatedTickIndicatorState extends State<AnimatedTickIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    // Listen for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call(); // Invoke callback
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget _buildContent() {
    if (widget.text.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: CustomPaint(
              key: ValueKey("tick"),
              size: Size(50, 50), // Using dart:ui's Size
              painter: CheckmarkPainter(_animation.value),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
            child: Text(widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.tickColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          )
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(12),
        child: CustomPaint(
          key: ValueKey("tick"),
          size: Size(50, 50),
          painter: CheckmarkPainter(_animation.value),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.systemGray6.withAlpha(255), // 背景颜色
          borderRadius: BorderRadius.circular(10), // 圆角半径
        ),
        child: IntrinsicWidth(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return _buildContent();
            },
          ),
        ),
      ),
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;

  CheckmarkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = MyColors.tickColor
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.3);

    final PathMetrics pathMetrics = path.computeMetrics();
    final Path extractPath = Path();

    for (final PathMetric metric in pathMetrics) {
      extractPath.addPath(
          metric.extractPath(0, metric.length * progress), Offset.zero);
    }

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
