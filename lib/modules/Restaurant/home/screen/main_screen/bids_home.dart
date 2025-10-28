import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/BidRequestCardShimmer.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/bloc/get_requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/bids_header.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/requests_search_bar.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:go_router/go_router.dart';

class MyBidsScreen extends StatefulWidget {
  static const path = '/businesshome';
  const MyBidsScreen({super.key});

  @override
  State<MyBidsScreen> createState() => _MyBidsScreenState();
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  late final GetRequestsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetRequestsBloc(ProviderRequestsRepository());
    _bloc.add(StartListeningRequests());
  }

  @override
  void dispose() {
    _bloc.add(StopListeningRequests());
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 16, 24, 32);
    final vertical = Responsive.responsiveSize(context, 12, 16, 20);

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: const Appbar(), // Ensure this is defined correctly
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.responsiveSize(context, 16, 20, 24),
                ),
                const RequestsSearchBar(),
                SizedBox(
                  height: Responsive.responsiveSize(context, 20, 24, 28),
                ),
                Expanded(
                  child: BlocBuilder<GetRequestsBloc, GetRequestsState>(
                    builder: (context, state) {
                      if (state is GetRequestsLoading) {
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: BidRequestCardShimmer(),
                            );
                          },
                        );
                      } else if (state is GetRequestsSuccess) {
                        final requests = state.requests;
                        if (requests.isEmpty) {
                          return const Center(
                            child: Text('No requests found.'),
                          );
                        }
                        return ListView.builder(
                          key: const ValueKey('requests_list'), // Ensure list stability
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            // Format data
                            final formattedPrice = CurrencyFormatter.format(
                              request.budgetDollars,
                            );
                            final formattedDate = DateFormatter.onlyDate(request.date);
                            final formattedTime = DateFormatter.onlyTime(request.date);
                            final formattedPeople = '${request.numPeople} people';
                            final formattedLocation = request.formattedAddress ?? 'Unknown location';

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: BidRequestCard(
                                key: ValueKey(request.id), // Unique key to prevent rebuilds
                                title: request.title,
                                postedBy: request.requestee?.name ?? 'Unknown',
                                price: formattedPrice,
                                dateText: formattedDate,
                                timeText: formattedTime,
                                peopleText: formattedPeople,
                                locationText: formattedLocation,
                                specialInstructionTitle: 'Special Instruction',
                                specialInstruction: request.status,
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
                      } else if (state is GetRequestsFailure) {
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
      ),
    );
  }
}