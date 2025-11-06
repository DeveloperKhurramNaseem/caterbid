import 'package:caterbid/modules/Producer/payment/screen/main_screen/payment_success_screen.dart';
import 'package:caterbid/modules/Restaurant/onboarding/screen/stripe_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/core/utils/helpers/formatter/formatted_date.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/formatted_bid_model.dart';
import 'package:caterbid/modules/Producer/accept_bid/bloc/acceptbid_bloc.dart';
import 'package:caterbid/modules/Producer/accept_bid/repository/accept_bid_repository.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_details.dart';
import '../widgets/payment_button.dart';

class PaymentScreen extends StatelessWidget {
  static const path = '/payment';
  final FormattedBidModel bid;

  const PaymentScreen({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return BlocProvider(
      create: (_) => AcceptbidBloc(AcceptBidRepository()),
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
            child: Column(
              children: [
                SizedBox(height: h * 0.04),
                const PaymentHeader(),
                SizedBox(height: h * 0.04),

                PaymentDetails(
                  title: bid.providerCompany,
                  location: bid.formattedLocation,
                  date: DateFormatter.fullDateTime(bid.createdAt),
                  amount: bid.amountDollars.toDouble(),
                ),

                const Spacer(),

                BlocConsumer<AcceptbidBloc, AcceptbidState>(
                  listener: (context, state) async {
                    if (state is AcceptBidSuccess) {
                      final checkoutUrl =
                          state.response['checkoutUrl'] as String;

                      // Open Stripe in-app
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StripeWebViewScreen(url: checkoutUrl),
                        ),
                      );

                      if (result == true) {
                        // Navigate to payment success screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentSuccessScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment cancelled')),
                        );
                      }
                    } else if (state is AcceptBidFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return PaymentButton(
                      onPressed: state is AcceptBidLoading
                          ? null
                          : () {
                              context.read<AcceptbidBloc>().add(
                                AcceptBidPressed(
                                  requestId:
                                      bid.requestId, // directly from model
                                  bidId: bid.id,
                                  
                                ),
                              );
                            },
                    );
                  },
                ),

                SizedBox(height: h * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
