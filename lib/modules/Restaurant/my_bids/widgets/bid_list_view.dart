// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'bids_card.dart';

class BidListView extends StatefulWidget {
  final List<Map<String, dynamic>> requests;

  const BidListView({super.key, required this.requests});

  @override
  State<BidListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<BidListView> {
  bool _refreshing = false;

  Future<void> _onRefresh() async {
    setState(() => _refreshing = true);
    await Future.delayed(const Duration(seconds: 1)); // simulate API
    setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.requests.isEmpty) {
      return const Center(
        child: Text("No requests found",
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.requests.length,
        itemBuilder: (context, index) {
          final req = widget.requests[index];
          return BidsCard(
            title: req["title"],
            location: req["location"],
            dateTime: req["dateTime"],
            amount: req["amount"],
            peopleCount: req["peopleCount"],
            status: req["status"],
          );
        },
      ),
    );
  }
}
