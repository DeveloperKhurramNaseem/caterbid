import 'package:caterbid/modules/Producer/my_requests/screen/widgets/request_list_view.dart';
import 'package:flutter/material.dart';

class FulfilledRequestsTab extends StatelessWidget {
  const FulfilledRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = [
      {
        "title": "Corporate Lunch Event",
        "location": "Los Angeles , CA",
        "dateTime": "Aug 10, 2024 , 12:00 pm",
        "amount": "\$450",
        "peopleCount": 300,
        "status": "Fulfilled",
      },
    ];

    return RequestListView(requests: requests);
  }
}
