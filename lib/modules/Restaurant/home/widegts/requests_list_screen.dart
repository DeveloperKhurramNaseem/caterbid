import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/widegts/request_card.dart';
import 'package:caterbid/modules/Restaurant/home/widegts/requests_search_bar.dart';

class RequestsListScreen extends StatelessWidget {
  const RequestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 12, 18, 24);
    final vertical = Responsive.responsiveSize(context, 12, 16, 20);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            children: [
              const RequestsSearchBar(),
              SizedBox(height: Responsive.responsiveSize(context, 18, 20, 24)),
              const BidRequestCard(
                title: 'Dinner for Film Crew',
                postedBy: 'AB Producer',
                price: '\$200',
                dateText: 'Sept 6, 2024',
                timeText: '1:30 pm',
                peopleText: '200 people',
                locationText: 'Hollywood, CA',
                specialInstructionTitle: 'Special Instruction',
                specialInstruction: 'Need gluten-free for 50 people',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
