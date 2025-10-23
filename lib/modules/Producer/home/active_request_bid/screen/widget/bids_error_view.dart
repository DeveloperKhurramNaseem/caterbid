import 'package:flutter/material.dart';

class BidsErrorView extends StatelessWidget {
  final String message;

  const BidsErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Error loading bids: $message",
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
