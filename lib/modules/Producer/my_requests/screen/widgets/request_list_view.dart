// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'request_card.dart';

class RequestListView extends StatefulWidget {
  final List<Map<String, dynamic>> requests;

  const RequestListView({super.key, required this.requests});

  @override
  State<RequestListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
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
          return RequestCard(
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
