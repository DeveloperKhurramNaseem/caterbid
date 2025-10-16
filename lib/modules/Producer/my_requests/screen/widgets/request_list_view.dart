import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/modules/Producer/home/model/producer_request_model.dart';
import 'package:flutter/material.dart';
import 'request_card.dart';

class RequestListView extends StatelessWidget {
  final List<ProducerRequest> requests;

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
          dateTime: DateFormatter.format(req.date),
          amount: req.budgetDollars,
          peopleCount: req.numPeople,
          status: req.status,
        );
      },
    );
  }
}
