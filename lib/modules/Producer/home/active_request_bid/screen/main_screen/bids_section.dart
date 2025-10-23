import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/bloc/bids_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/repository/producer_bid_repository.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/screen/widget/bids_empty_view.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/screen/widget/bids_error_view.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/screen/widget/bids_loaded_view.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/screen/widget/bids_loading_view.dart';

class BidsSection extends StatelessWidget {
  final String requestId;

  const BidsSection({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BidsBloc(BidsRepository())
        ..add(StartListeningBids(requestId)), 
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<BidsBloc, BidsState>(
            builder: (context, state) {
              if (state is BidsLoading) return const BidsLoadingView();
              if (state is BidsError) return BidsErrorView(message: state.message);
              if (state is BidsEmpty) return const BidsEmptyView();
              if (state is BidsLoaded) {
                return BidsLoadedView(
                  bids: state.bids,
                  maxWidth: constraints.maxWidth,
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
