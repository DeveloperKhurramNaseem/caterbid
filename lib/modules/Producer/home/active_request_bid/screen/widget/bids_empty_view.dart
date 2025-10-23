import 'package:flutter/material.dart';

class BidsEmptyView extends StatelessWidget {
  const BidsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          "No bids received yet.",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
