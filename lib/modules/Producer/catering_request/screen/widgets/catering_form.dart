import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/map/reusable_map_picker.dart';
import 'package:caterbid/core/utils/helpers/check_location_enabled.dart';
import 'package:caterbid/modules/Producer/catering_request/bloc/cateringrequest_bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/model/catering_request_model.dart';
import 'package:caterbid/modules/Producer/home/active_request/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/main_screen/home_screen.dart';
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

  double? _selectedLat;
  double? _selectedLng;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _titleController.dispose();
    _peopleController.dispose();
    _budgetController.dispose();
    _locationController.dispose();
    _specialController.dispose();
    super.dispose();
  }

  /// --- Open Map Safely ---
  Future<void> _openMap() async {
    if (!mounted) return;

    bool canOpen = await checkLocationEnabled(context);
    if (!canOpen || !mounted) return;

  final result = await context.push<Map<String, dynamic>>(ReusableMapPicker.path);


    if (mounted && result != null) {
      setState(() {
        _locationController.text = result['address'] ?? '';
        _selectedLat = result['lat'];
        _selectedLng = result['lng'];
      });
    }
  }

  /// --- Submit Request ---
  void _submitRequest() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedLat == null || _selectedLng == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter location')),
      );
      return;
    }

    final dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final requestModel = CateringRequestModel(
      title: _titleController.text.trim(),
      budget: int.tryParse(_budgetController.rawValue) ?? 0,
      currency: 'usd',
      peopleCount: int.tryParse(_peopleController.rawValue) ?? 1,
      date: dateTime,
      lat: _selectedLat!,
      lng: _selectedLng!,
      description: _specialController.text,
    );

    context.read<CateringrequestBloc>().add(
          CreateCateringRequest(requestModel),
        );
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return BlocConsumer<CateringrequestBloc, CateringrequestState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state is CateringSuccess) {
          context.read<ProducerHomeBloc>().add(
                FetchProducerRequests(afterCreation: true),
              );
          context.read<RequestsBloc>().add(RefreshMyRequests());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Catering request created successfully!'),
            ),
          );

          context.go(ProducerHomeScreen.path, extra: true);
        } else if (state is CateringFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CateringLoading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              CustomTextField(
                label: "Title",
                controller: _titleController,
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Title is required' : null,
                capitalizeFirstLetter: true,
              ),
              SizedBox(height: h * 0.02),

              // Number of People
              CustomTextField(
                label: "Number of People",
                controller: _peopleController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final people = int.tryParse(value?.replaceAll(',', '') ?? '');
                  return (people == null || people <= 0)
                      ? 'Enter a valid number of people'
                      : null;
                },
                formatNumber: true,
              ),
              SizedBox(height: h * 0.02),

              // Budget
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
                  return (budget == null || budget <= 0)
                      ? 'Enter a valid budget'
                      : null;
                },
                formatNumber: true,
              ),
              SizedBox(height: h * 0.02),

              // Date & Time
              CateringDateTimePicker(
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                onDateChanged: (date) => setState(() => _selectedDate = date),
                onTimeChanged: (time) => setState(() => _selectedTime = time),
              ),
              SizedBox(height: h * 0.02),

              // Location
              CustomTextField(
                label: "Location",
                controller: _locationController,
                readOnly: true,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Please choose your location from map' : null,
                suffixIcon: Icon(Icons.location_on, color: AppColors.icon),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _openMap,
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

              // Special Instructions
              CateringSpecialInstructionsField(controller: _specialController),
              SizedBox(height: h * 0.04),

              // Submit
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.c500),
                    )
                  : CateringSubmitButton(onPressed: _submitRequest),
            ],
          ),
        );
      },
    );
  }
}
