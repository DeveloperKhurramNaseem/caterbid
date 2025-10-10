import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/catering_request/screen/widgets/catering_appbar.dart';
import 'package:caterbid/modules/Producer/catering_request/screen/widgets/catering_form.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class NewCateringRequestScreen extends StatelessWidget {
  const NewCateringRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const CateringAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.06,
            vertical: h * 0.02,
          ),
          child: const CateringForm(),
        ),
      ),
    );
  }
}
