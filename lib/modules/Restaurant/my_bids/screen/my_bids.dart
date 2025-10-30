import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/modules/Restaurant/my_bids/widgets/bids_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/my_bids/bloc/get_my_bids_bloc.dart';
import 'package:caterbid/modules/Restaurant/my_bids/widgets/header_with_tabs.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/bids_header.dart';

class MyBids extends StatefulWidget {
  static const String path = '/mybids';
  const MyBids({super.key});

  @override
  State<MyBids> createState() => _MyBidsScreenState();
}

class _MyBidsScreenState extends State<MyBids> {
  bool isActiveTab = true;

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<GetMyBidsBloc>().add(FetchMyBidsEvent());
  });
}

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.responsiveSize(
      context,
      16,
      32,
      60,
    );

    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const Appbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: h * 0.01),
              HeaderWithTabs(
                isActiveTab: isActiveTab,
                onActiveTap: () {
                  setState(() => isActiveTab = true);
                  context.read<GetMyBidsBloc>().add(const FilterBidsEvent(isActive: true));
                },
                onFulfilledTap: () {
                  setState(() => isActiveTab = false);
                  context.read<GetMyBidsBloc>().add(const FilterBidsEvent(isActive: false));
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<GetMyBidsBloc, GetMyBidsState>(
                  builder: (context, state) {
                    if (state is GetMyBidsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.c500),
                      );
                    } else if (state is GetMyBidsLoaded) {
                      if (state.bids.isEmpty) {
                        return const Center(
                          child: Text(
                            "No bids found",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.bids.length,
                        itemBuilder: (context, index) {
                          final bid = state.bids[index];
                         final bidDate = DateFormatter.formatExact(bid.request.date);
                          return BidsCard(
                            title: bid.request.title,
                            postedBy: 'Cater Bid',
                            location: bid.request.location.type,
                            dateTime: bidDate,
                            amount: "\$${bid.amountDollars}",
                            peopleCount: bid.request.numPeople,
                            status: bid.status,
                            myBidAmount: "\$${bid.amountDollars}",
                            myBidDescription: bid.description ?? "No details",
                          );
                        },
                      );
                    } else if (state is GetMyBidsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
