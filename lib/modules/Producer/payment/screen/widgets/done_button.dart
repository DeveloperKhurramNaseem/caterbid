import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Done',
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}