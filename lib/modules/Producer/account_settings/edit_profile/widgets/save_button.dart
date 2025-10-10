import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.05),
      child: CustomButton(
        title: "Save Changes",
        onPressed: () {
          // TODO: Add save logic
        },
      ),
    );
  }
}
