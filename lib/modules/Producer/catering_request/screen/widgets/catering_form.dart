import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'catering_date_time_picker.dart';
import 'catering_special_instructions_field.dart';
import 'catering_submit_button.dart';
import 'package:go_router/go_router.dart';

class CateringForm extends StatefulWidget {
  const CateringForm({super.key});

  @override
  State<CateringForm> createState() => _CateringFormState();
}

class _CateringFormState extends State<CateringForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _peopleController = TextEditingController();
  final _budgetController = TextEditingController();
  final _locationController = TextEditingController();
  final _specialController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(label: "Title", controller: _titleController),
          SizedBox(height: h * 0.02),

          CustomTextField(
            label: "Number of People",
            controller: _peopleController,
          ),
          SizedBox(height: h * 0.02),

          CustomTextField(
            label: "Budget",
            controller: _budgetController,
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(
                Icons.attach_money_rounded,
                color: AppColors.icon,
                size: 22,
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          CateringDateTimePicker(
            selectedDate: _selectedDate,
            selectedTime: _selectedTime,
            onDateChanged: (date) => setState(() => _selectedDate = date),
            onTimeChanged: (time) => setState(() => _selectedTime = time),
          ),

          SizedBox(height: h * 0.02),

          CustomTextField(label: "Location", controller: _locationController),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Choose from Map',
                  style: TextStyle(
                    color: AppColors.icon,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          CateringSpecialInstructionsField(controller: _specialController),

          SizedBox(height: h * 0.04),

          CateringSubmitButton(
            onPressed: () {
              context.go(ProducerHomeScreen.path, extra: true);

              if (_formKey.currentState!.validate()) {
                final dateTime = DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  _selectedTime.hour,
                  _selectedTime.minute,
                );

                debugPrint("📅 Date: $dateTime");
                debugPrint("📝 Title: ${_titleController.text}");
              }
            },
          ),
        ],
      ),
    );
  }
}
