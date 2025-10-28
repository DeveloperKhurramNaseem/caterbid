import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed; 
  final bool isLoading;
  final bool isEnabled;

  const SaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false, required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.05),
      child: CustomButton(
        title: isLoading ? "Saving..." : "Save Changes",
        onPressed: isEnabled ? onPressed : null,
      ),
    );
  }
}
