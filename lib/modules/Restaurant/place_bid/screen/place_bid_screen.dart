import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/place_bid/bloc/place_bid_bloc.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/catering_details_card.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/place_bid_form.dart';
import 'package:caterbid/modules/Restaurant/place_bid/widgets/request_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:go_router/go_router.dart';

class PlaceBidScreen extends StatelessWidget {
  static const path = '/placebid';
  final ProviderRequest request;

  const PlaceBidScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.responsiveSize(context, 16, 20, 24);
    final formattedData = RequestDataFormatter.formatRequest(request);

    return Scaffold(
      appBar: const NavigationbarTitle(title: "Place Bid"),
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<PlaceBidBloc, PlaceBidState>(
        listener: (context, state) {
          if (state is PlaceBidSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Bid placed successfully!')),
            );
            context.pop();
          } else if (state is PlaceBidFailure) {
            final errorMessage = ApiErrorHandler.errorMessage(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ $errorMessage')),
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
                CateringDetailsCard(
                  title: request.title,
                  postedBy: formattedData['postedBy']!,
                  price: formattedData['price']!,
                  dateText: formattedData['date']!,
                  timeText: formattedData['time']!,
                  peopleText: formattedData['people']!,
                  locationText: formattedData['location']!,
                  specialInstruction: formattedData['specialInstruction']!,
                ),
                SizedBox(height: spacing),
                BidForm(
                  initialPeople: request.numPeople.toString(),
                  initialPrice: request.budgetDollars.toString(),
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