import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/producer_request_model.dart';
import 'package:flutter/material.dart';

class ProducerRequestCard extends StatelessWidget {
  final ProducerRequest request;

  const ProducerRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    final formattedDate = DateFormatter.formatExact(request.date);

    final budget = request.budgetDollars;
    String formatted = CurrencyFormatter.format(budget); 

    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Top Row (Title + Right section: Budget + People) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Left Column (Header + Title + Details)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Catering Request Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.045,
                        color: const Color(0xFF0A2A33),
                      ),
                    ),
                    SizedBox(height: h * 0.012),
                    Text(
                      request.title,
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: h * 0.006),
                    Text(
                      "Hollywood, CA", // TODO: Replace when API provides location
                      style: TextStyle(
                        fontSize: w * 0.035,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: h * 0.006),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: w * 0.035,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              /// Right Column (Budget + People)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatted,
                    style: TextStyle(
                      color: AppColors.icon,
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.045,
                    ),
                  ),
                  SizedBox(height: h * 0.006),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_rounded,
                        color: Colors.orange,
                        size: w * 0.045,
                      ),
                      SizedBox(width: w * 0.008),
                      Text(
                        "${request.numPeople} people",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: const Color(0xFF0A2A33),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
