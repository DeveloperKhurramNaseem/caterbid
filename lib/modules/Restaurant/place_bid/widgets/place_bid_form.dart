import 'dart:io';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/helpers/file_validation_helper.dart';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:caterbid/modules/Restaurant/place_bid/bloc/place_bid_bloc.dart';
import 'package:caterbid/modules/Restaurant/place_bid/model/place_bid_formdata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

class BidForm extends StatefulWidget {
  final String currency;
  final String requestId;
  final bool isLoading;
  final VoidCallback? onSubmit;

  const BidForm({
    super.key,
    required this.currency,
    required this.requestId,
    this.isLoading = false,
    this.onSubmit,
  });

  @override
  State<BidForm> createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageFileNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _attachedFile;
  bool _isFileValid = true; // Tracks if the selected file meets criteria

  @override
  void initState() {
    super.initState();
    // peopleController.text = widget.initialPeople;
    // priceController.text = widget.initialPrice;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    imageFileNameController.dispose();
    priceController.dispose();
    super.dispose();
  }

Future<void> _pickAttachment() async {
  final picked = await ImagePickerHelper.pickFile(context);
  if (picked == null) return;

  final result = await FileValidationHelper.validateFile(picked);

  if (!result.isValid) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'Invalid file')),
      );
    }
    setState(() => _isFileValid = false);
    return;
  }

  setState(() {
    _attachedFile = picked;
    _isFileValid = true;
    final cleanName = picked.path.split('/').last.replaceAll(RegExp(r'^image_picker_|^file_picker_'), '');
    imageFileNameController.text = cleanName;
  });
}


  void _submit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() != true || !_isFileValid) {
      if (!_isFileValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a valid file (.jpg, .jpeg, .png, .pdf, max 1MB)',
            ),
          ),
        );
      }
      return;
    }

    final bid = PlaceBidRequest(
      requestId: widget.requestId,
      amount: priceController.text.replaceAll(',', ''),
      currency: widget.currency,
      description: descriptionController.text.isEmpty
          ? null
          : descriptionController.text,
      attachment: _attachedFile,
    );

    widget.onSubmit?.call();
    context.read<PlaceBidBloc>().add(SubmitPlaceBid(bid));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.responsiveSize(context, 16, 20, 24);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Bid",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveSize(context, 16, 18, 20),
            ),
            semanticsLabel: 'Your Bid Section',
          ),
          SizedBox(height: spacing / 2),

          SizedBox(height: spacing / 1.5),
          CustomTextField(
            label: "Price",
            controller: priceController,
            keyboardType: const TextInputType.numberWithOptions(),
            formatNumber: true,
            validator: (value) {
              final cleanedValue = value?.replaceAll(',', '') ?? '';
              if (cleanedValue.isEmpty) {
                return 'Price is required';
              }
              final price = int.tryParse(cleanedValue);
              if (price == null || price <= 0) {
                return 'Enter a valid price';
              }
              return null;
            },
            suffixIcon: const Icon(Icons.attach_money, color: Colors.orange),
          ),
          SizedBox(height: spacing / 1.5),
          SpecialInstructionsField(
            controller: descriptionController,
            labelTextHolder: 'Menu / Description (Optional)',
            iconData: Icons.attach_file,
            onIconTap: _pickAttachment,
          ),
          if (_attachedFile != null) ...[
            SizedBox(height: spacing / 2),
            Row(
              children: [
                const Icon(Icons.insert_drive_file, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    imageFileNameController.text,
                    style: TextStyle(
                      color: _isFileValid ? AppColors.textDark : Colors.red,
                    ),
                    overflow: TextOverflow.ellipsis,
                    semanticsLabel:
                        'Attached File: ${imageFileNameController.text}',
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spacing * 1.5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading || !_isFileValid ? null : _submit,

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.c500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Place Bid",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      semanticsLabel: 'Place Bid Button',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
