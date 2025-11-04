import 'package:flutter/material.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/formatted_producer_request.dart';
import 'request_card.dart';

class RequestListView extends StatelessWidget {
  final List<FormattedProducerRequest> requests;

  const RequestListView({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Text(
          "No requests found",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];

        return RequestCard(
          title: req.title,
          location: req.formattedLocation,
          dateTime: req.formattedDate,
          amount: req.formattedBudget,
          peopleCount: req.formattedPeople,
          status: req.status,
        );
      },
    );
  }
}
