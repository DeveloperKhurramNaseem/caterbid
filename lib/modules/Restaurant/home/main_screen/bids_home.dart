import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/widegts/bids_header.dart';
import 'package:caterbid/modules/Restaurant/home/widegts/requests_search_bar.dart';
import 'package:caterbid/modules/Restaurant/home/widegts/request_card.dart';

class MyBidsScreen extends StatelessWidget {
  static const path = '/businesshome';
  const MyBidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 16, 24, 32);
    final vertical = Responsive.responsiveSize(context, 12, 16, 20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.responsiveSize(context, 16, 20, 24)),
              const RequestsSearchBar(),
              SizedBox(height: Responsive.responsiveSize(context, 20, 24, 28)),
              Expanded(
                child: ListView(
                  children: const [
                    BidRequestCard(
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
                    SizedBox(height: 16),
                    BidRequestCard(
                      title: 'Corporate Lunch Event',
                      postedBy: 'Catering Hub',
                      price: '\$350',
                      dateText: 'Oct 20, 2024',
                      timeText: '12:00 pm',
                      peopleText: '150 people',
                      locationText: 'Downtown LA',
                      specialInstructionTitle: 'Special Instruction',
                      specialInstruction: 'Include 10 vegan options',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
