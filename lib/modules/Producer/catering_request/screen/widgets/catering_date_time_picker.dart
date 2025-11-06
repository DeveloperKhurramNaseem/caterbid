import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class CateringDateTimePicker extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const CateringDateTimePicker({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2026),
              );
              if (picked != null) onDateChanged(picked);
            },
            child: _buildInputBox(
              label: "Date",
              value: DateFormat('dd/MM/yyyy').format(selectedDate),
              icon: Icons.calendar_today,
            ),
          ),
        ),
        SizedBox(width: w * 0.04),
        Expanded(
          child: InkWell(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );
              if (picked != null) onTimeChanged(picked);
            },
            child: _buildInputBox(
              label: "Time",
              value: selectedTime.format(context),
              icon: Icons.access_time,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputBox({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontFamily: AppFonts.nunito)),
          Icon(icon, color: AppColors.icon),
        ],
      ),
    );
  }
}
