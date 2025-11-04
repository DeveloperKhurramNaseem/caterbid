import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const PullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.orange,
      backgroundColor: Colors.white,
      displacement: 50,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: onRefresh,
      child: Stack(
        children: [
          child,
          const Positioned(top: 10, left: 0, right: 0, child: Center()),
        ],
      ),
    );
  }
}
