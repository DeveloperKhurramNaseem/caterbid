import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/BidRequestCardShimmer.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/request_card.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/request_formatter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestsListView extends StatelessWidget {
  final List<ProviderRequest> requests;
  final bool isLoading;

  const RequestsListView({
    super.key,
    required this.requests,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: BidRequestCardShimmer(),
          );
        },
      );
    }

    if (requests.isEmpty) {
      return const Center(child: Text('No requests found.'));
    }

    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        final formattedData = RequestDataFormatter.formatRequest(request);

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: BidRequestCard(
            title: formattedData['title']!,
            postedBy: formattedData['postedBy']!,
            price: formattedData['price']!,
            dateText: formattedData['date']!,
            timeText: formattedData['time']!,
            peopleText: formattedData['people']!,
            locationText: formattedData['location']!,
            specialInstructionTitle: 'Special Instruction',
            specialInstruction: formattedData['specialInstruction']!,
            onPlaceBid: () {
              context.push(
                PlaceBidScreen.path,
                extra: request,
              );
            },
          ),
        );
      },
    );
  }
}