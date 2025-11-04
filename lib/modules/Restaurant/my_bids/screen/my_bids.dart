import 'package:caterbid/core/widgets/pull_to_refresh.dart';
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
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetMyBidsBloc>().add(FetchMyBidsEvent());
    });
  }

  Future<void> _handleRefresh() async {
    context.read<GetMyBidsBloc>().add(RefreshMyBidsEvent());
    await Future.delayed(const Duration(milliseconds: 600));
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
                  context
                      .read<GetMyBidsBloc>()
                      .add(const FilterBidsEvent(isActive: true));
                },
                onFulfilledTap: () {
                  setState(() => isActiveTab = false);
                  context
                      .read<GetMyBidsBloc>()
                      .add(const FilterBidsEvent(isActive: false));
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<GetMyBidsBloc, GetMyBidsState>(
                  builder: (context, state) {
                    // Show loader only for very first fetch
                    if (state is GetMyBidsLoading && _isFirstLoad) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.icon),
                      );
                    }

                    // Once first load completes, no more central loader
                    if (state is GetMyBidsLoaded) {
                      _isFirstLoad = false;

                      if (state.bids.isEmpty) {
                        return PullToRefresh(
                          onRefresh: _handleRefresh,
                          child: ListView(
                            physics:
                                const AlwaysScrollableScrollPhysics(), // enables pull
                            children: const [
                              SizedBox(height: 150),
                              Center(
                                child: Text(
                                  "No bids found",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return PullToRefresh(
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          physics:
                              const AlwaysScrollableScrollPhysics(), // needed for refresh
                          itemCount: state.bids.length,
                          itemBuilder: (context, index) {
                            final bid = state.bids[index];
                            return BidsCard(
                              title: bid.title,
                              postedBy: 'Cater Bid',
                              location: bid.formattedLocation,
                              dateTime: bid.formattedDate,
                              amount: bid.formattedAmount,
                              peopleCount: bid.formattedPeople,
                              status: bid.status,
                              myBidAmount: bid.formattedAmount,
                              myBidDescription:
                                  bid.description ?? "No details",
                            );
                          },
                        ),
                      );
                    }

                    if (state is GetMyBidsError) {
                      _isFirstLoad = false;
                      return PullToRefresh(
                        onRefresh: _handleRefresh,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: h * 0.3),
                            Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
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
