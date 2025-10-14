import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class RequestsSearchBar extends StatelessWidget {
  const RequestsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);
    final height = Responsive.responsiveSize(context, 48, 54, 60);

    return Row(
      children: [
        // Search Field
        Expanded(
          child: SizedBox(
            height: height,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Requests',
                prefixIcon: Icon(Icons.search, size: Responsive.responsiveSize(context, 20, 22, 24)),
                contentPadding: EdgeInsets.symmetric(horizontal: Responsive.responsiveSize(context, 12, 14, 16)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.35)),
                ),
              ),
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ),

        SizedBox(width: Responsive.responsiveSize(context, 8, 10, 12)),

        // Filter Icon
        Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.25)),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune_rounded, size: Responsive.responsiveSize(context, 20, 22, 24)),
            splashRadius: 20,
          ),
        ),

        SizedBox(width: Responsive.responsiveSize(context, 8, 10, 12)),

        // Sort Button
        Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: Responsive.responsiveSize(context, 10, 12, 14)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Text('Sort', style: TextStyle(fontSize: fontSize)),
              const SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down_rounded, size: Responsive.responsiveSize(context, 20, 22, 24)),
            ],
          ),
        ),
      ],
    );
  }
}
