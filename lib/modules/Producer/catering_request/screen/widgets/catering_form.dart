import 'package:caterbid/modules/Producer/catering_request/bloc/cateringrequest_bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/model/catering_request_model.dart';
import 'package:caterbid/modules/Producer/home/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'catering_date_time_picker.dart';
import 'catering_special_instructions_field.dart';
import 'catering_submit_button.dart';

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

    return BlocConsumer<CateringrequestBloc, CateringrequestState>(
      listener: (context, state) {
        if (state is CateringSuccess) {

          context.read<RequestsBloc>().add(RefreshMyRequests());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Catering request created successfully!'),
            ),
          );

          // Refresh home only after API confirms request creation
          context.read<ProducerHomeBloc>().add(
            FetchProducerRequests(afterCreation: true),
          );

          context.go(ProducerHomeScreen.path, extra: true);
        } else if (state is CateringFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is CateringLoading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Title Field ---
              CustomTextField(
                label: "Title",
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                capitalizeFirstLetter: true,
              ),
              SizedBox(height: h * 0.02),

              /// --- Number of People ---
              CustomTextField(
                label: "Number of People",
                controller: _peopleController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final people = int.tryParse(value?.replaceAll(',', '') ?? '');
                  if (people == null || people <= 0) {
                    return 'Enter a valid number of people';
                  }
                  return null;
                },
                formatNumber: true,
              ),

              SizedBox(height: h * 0.02),

              /// --- Budget Field ---
              CustomTextField(
                label: "Budget",
                controller: _budgetController,
                keyboardType: TextInputType.number,
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: AppColors.icon,
                    size: 22,
                  ),
                ),
                validator: (value) {
                  final budget = int.tryParse(value?.replaceAll(',', '') ?? '');
                  if (budget == null || budget <= 0) {
                    return 'Enter a valid budget';
                  }
                  return null;
                },
                formatNumber: true,
              ),

              SizedBox(height: h * 0.02),

              /// --- Date & Time Picker ---
              CateringDateTimePicker(
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                onDateChanged: (date) => setState(() => _selectedDate = date),
                onTimeChanged: (time) => setState(() => _selectedTime = time),
              ),
              SizedBox(height: h * 0.02),

              /// --- Location Field ---
              CustomTextField(
                label: "Location",
                controller: _locationController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Future: Open map picker here
                    },
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

              /// --- Optional Field ---
              CateringSpecialInstructionsField(controller: _specialController),
              SizedBox(height: h * 0.04),

              /// --- Submit Button ---
              isLoading
                  ? const Center(child: CircularProgressIndicator(
                    color: AppColors.c500,
                  ))
                  : CateringSubmitButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final dateTime = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                          );

                          // Hardcoded lat/lng for now
                          const lat = 37.7749;
                          const lng = -122.4194;

                          final requestModel = CateringRequestModel(
                            title: _titleController.text.trim(),
                            budget:
                                int.tryParse(_budgetController.rawValue) ?? 0,

                            currency: 'usd',
                            peopleCount:
                                int.tryParse(_peopleController.rawValue) ?? 1,

                            date: dateTime,
                            lat: lat,
                            lng: lng,
                            specialInstructions: _specialController.text.trim(),
                          );

                          context.read<CateringrequestBloc>().add(
                            CreateCateringRequest(requestModel),
                          );
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
