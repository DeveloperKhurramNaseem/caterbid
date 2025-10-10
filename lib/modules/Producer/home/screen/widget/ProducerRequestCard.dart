import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ProducerRequestCard extends StatelessWidget {
  const ProducerRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catering Request Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.045),
          ),
          SizedBox(height: h * 0.008),
          Text(
            "Dinner for Film Crew",
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: h * 0.006),
          Text("Hollywood, CA", style: TextStyle(fontSize: w * 0.035)),
          SizedBox(height: h * 0.006),
          Text("Sept 6, 2024, 1:30 pm", style: TextStyle(fontSize: w * 0.035)),
          SizedBox(height: h * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, color: Colors.orange),
                  SizedBox(width: w * 0.015),
                  Text("200 people", style: TextStyle(fontSize: w * 0.035)),
                ],
              ),
              Text(
                "\$200",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.045,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
