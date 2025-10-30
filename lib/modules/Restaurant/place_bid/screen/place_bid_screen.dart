// modules/Restaurant/place_bid/screen/place_bid_screen.dart
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/model/formatted_request_model.dart';
import 'package:caterbid/modules/Restaurant/place_bid/bloc/place_bid_bloc.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/catering_details_card.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/place_bid_appbar.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/place_bid_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PlaceBidScreen extends StatelessWidget {
  static const path = '/placebid';
  final FormattedProviderRequest request;

  const PlaceBidScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.responsiveSize(context, 16, 20, 24);

    return Scaffold(
      appBar: const PlaceBidAppbar(title: "Place Bid"),
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<PlaceBidBloc, PlaceBidState>(
        listener: (context, state) {
          if (state is PlaceBidSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bid placed successfully!')),
            );
            context.pop();
          } else if (state is PlaceBidFailure) {
            final errorMessage = ApiErrorHandler.errorMessage(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: $errorMessage')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PlaceBidLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // All data is already formatted in BLoC
                CateringDetailsCard(
                  title: request.title,
                  postedBy: request.requestee?.name ?? 'Unknown',
                  price: request.formattedPrice,
                  dateText: request.formattedDate,
                  timeText: request.formattedTime,
                  peopleText: request.formattedPeople,
                  locationText: request.formattedLocation,
                  specialInstruction: request.description?.isNotEmpty == true
                      ? request.description
                      : null,
                ),

                SizedBox(height: spacing),

                // Pass only what BidForm needs
                BidForm(
                  currency: request.currency,
                  requestId: request.id,
                  isLoading: isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}