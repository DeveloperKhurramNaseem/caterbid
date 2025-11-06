import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed; 
  final bool isLoading;
  final bool isEnabled;

  const SaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.05),
      child: CustomButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        isEnabled: isEnabled && !isLoading,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                "Save Changes",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }
}
