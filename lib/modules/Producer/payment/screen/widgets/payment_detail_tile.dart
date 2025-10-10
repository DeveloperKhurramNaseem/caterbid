import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class PaymentDetailTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailingText;
  final int? peopleCount;

  const PaymentDetailTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingText,
    this.peopleCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppFonts.nunito,

                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              trailingText,
              style: const TextStyle(
                fontFamily: AppFonts.nunito,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (peopleCount != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.group, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "$peopleCount people",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
}
