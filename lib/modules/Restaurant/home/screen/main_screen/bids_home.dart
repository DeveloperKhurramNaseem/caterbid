// screen/my_bids_screen.dart
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/home/bloc/get_requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/BidRequestCardShimmer.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/bids_header.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/request_card.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/requests_search_bar.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyBidsScreen extends StatefulWidget {
  static const path = '/businesshome';
  const MyBidsScreen({super.key});

  @override
  State<MyBidsScreen> createState() => _MyBidsScreenState();
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch provider profile first
    context.read<ProviderProfileBloc>().add(LoadProviderProfileEvent());

    // Load requests
    // context.read<GetRequestsBloc>().add(StartListeningRequests());
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 16, 24, 32);
    final vertical = Responsive.responsiveSize(context, 12, 16, 20);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const Appbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.responsiveSize(context, 16, 20, 24)),
              const RequestsSearchBar(),
              SizedBox(height: Responsive.responsiveSize(context, 20, 24, 28)),
              Expanded(
                child: BlocBuilder<GetRequestsBloc, GetRequestsState>(
                  builder: (context, state) {
                    if (state is GetRequestsLoading) {
                      return _buildShimmer();
                    }
                    if (state is GetRequestsSuccess) {
                      final requests = state.requests;
                      if (requests.isEmpty) {
                        return const Center(child: Text('No requests found.'));
                      }
                      return ListView.builder(
                        key: const ValueKey('requests_list'),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final req = requests[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: BidRequestCard(
                              key: ValueKey(req.id),
                              title: req.title,
                              postedBy: req.requestee?.name ?? 'Unknown',
                              price: req.formattedPrice,
                              dateText: req.formattedDate,
                              timeText: req.formattedTime,
                              peopleText: req.formattedPeople,
                              locationText: req.formattedLocation,
                              specialInstruction: req.description,
                              onPlaceBid: () {
                                context.push(PlaceBidScreen.path, extra: req);
                              },
                            ),
                          );
                        },
                      );
                    }
                    if (state is GetRequestsFailure) {
                      return Center(child: Text('Error: ${state.error}'));
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

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: BidRequestCardShimmer(),
      ),
    );
  }
}
