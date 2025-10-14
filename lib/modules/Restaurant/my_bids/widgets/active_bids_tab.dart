import 'package:caterbid/modules/Restaurant/my_bids/widgets/bid_list_view.dart';
import 'package:flutter/material.dart';

class ActiveRequestsTab extends StatelessWidget {
  const ActiveRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = [
      {
        "title": "Dinner for Film Crew",
        "location": "Hollywood , CA",
        "dateTime": "Sept 6, 2024 , 1:30 pm",
        "amount": "\$200",
        "peopleCount": 200,
        "status": "Active",
      },
    ];

    return BidListView(requests: requests);
  }
}
