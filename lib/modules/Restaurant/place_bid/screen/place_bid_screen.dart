import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import '../widgets/catering_details_card.dart';
import '../widgets/place_bid_button.dart';

class PlaceBidScreen extends StatefulWidget {
  static const path = '/placebid';

  const PlaceBidScreen({super.key});

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.responsiveSize(context, 16, 20, 24);

    return Scaffold(
      appBar: NavigationbarTitle(title: "Place Bid"),
      backgroundColor: AppColors.appBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CateringDetailsCard(),
            SizedBox(height: spacing),
            Text(
              "Your Bid",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.responsiveSize(context, 16, 18, 20),
              ),
            ),
            SizedBox(height: spacing / 2),
            const CustomTextField(label: "Number of People"),
            SizedBox(height: spacing / 1.5),
            const CustomTextField(
              label: "Price",
              suffixIcon: Icon(Icons.attach_money, color: Colors.orange),
            ),
            SizedBox(height: spacing / 1.5),

            SpecialInstructionsField(
              controller: descriptionController,
              labelTextHolder: 'Description',
            ),

            SizedBox(height: spacing * 1.5),
            const PlaceBidButton(),
          ],
        ),
      ),
    );
  }
}
