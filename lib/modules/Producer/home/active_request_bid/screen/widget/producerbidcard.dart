import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/helpers/formatter/formatted_date.dart';
import 'package:caterbid/modules/Producer/accept_bid/screen/main_screen/payment_screen.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/formatted_bid_model.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:caterbid/core/network/api_endpoints.dart';

class ProducerBidCard extends StatelessWidget {
  final FormattedBidModel bid;

  const ProducerBidCard({super.key, required this.bid});

  bool _isImageFile(String url) {
    final extension = path.extension(url).toLowerCase();
    return ['.jpg', '.jpeg', '.png'].contains(extension);
  }

  Future<void> _openAttachment(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.015),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: bid.providerProfileUrl != null
                    ? Image.network(
                        Uri.parse(ApiEndpoints.baseUrl)
                            .resolve(bid.providerProfileUrl!)
                            .toString(),
                        height: h * 0.08,
                        width: h * 0.08,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/icons/app_icon.png',
                                height: h * 0.08, width: h * 0.08),
                      )
                    : Image.asset('assets/icons/app_icon.png',
                        height: h * 0.08, width: h * 0.08),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bid.providerCompany,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: w * 0.04)),
                    Text("\$${bid.amountDollars} / ${bid.numPeople} people",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.035)),
                    Text(bid.formattedLocation, style: TextStyle(fontSize: w * 0.033)),
                    Text(DateFormatter.fullDateTime(bid.createdAt),
                        style: TextStyle(fontSize: w * 0.033)),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.01),
          Text(bid.description, style: TextStyle(fontSize: w * 0.034)),

          if (bid.attachmentUrl != null) ...[
            SizedBox(height: h * 0.012),
            GestureDetector(
              onTap: () async {
                try {
                  await _openAttachment(bid.attachmentUrl!);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to open attachment: $e')),
                  );
                }
              },
              child: Text(
                "See attached menu 📎",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                  fontSize: w * 0.035,
                ),
              ),
            ),
          ],

          SizedBox(height: h * 0.015),
          SizedBox(
            width: double.infinity,
            height: h * 0.055,
            child: ElevatedButton(
              onPressed: () {
                context.push(PaymentScreen.path, extra: bid);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Accept Bid",
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  color: Colors.white,
                  fontSize: w * 0.037,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
