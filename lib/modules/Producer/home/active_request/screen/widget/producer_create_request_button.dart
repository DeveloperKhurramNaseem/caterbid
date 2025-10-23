import 'package:caterbid/modules/Producer/catering_request/screen/main_screen/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProducerCreateRequestButton extends StatelessWidget {
  const ProducerCreateRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          context.push(NewCateringRequestScreen.path);
        },
        child: Text(
          'Create Request',
          style: TextStyle(
            fontSize: Responsive.responsiveSize(context, 16, 18, 20),
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
