import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/BidRequestCardShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/bloc/get_requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/bids_header.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/requests_search_bar.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/request_card.dart';

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
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: const BidRequestCardShimmer(),
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
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            final formatted = CurrencyFormatter.format(
                              request.budgetDollars,
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: BidRequestCard(
                                title: request.title,
                                postedBy: request.requestee?.name ?? 'Unknown',
                                price: formatted,
                                dateText: DateFormatter.short(request.date),
                                timeText: '',
                                peopleText: '${request.numPeople} people',
                                locationText:
                                    'Lat: ${request.location.latitude.toStringAsFixed(4)}, Lng: ${request.location.longitude.toStringAsFixed(4)}',
                                specialInstructionTitle: 'Special Instruction',
                                specialInstruction: request.status,
                                requestId: request.id,
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
