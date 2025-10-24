import 'dart:io';
import 'package:caterbid/modules/Restaurant/place_bid/model/place_bid_formdata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/helpers/image_picker_helper.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/core/widgets/special_instructions_field.dart';
import 'package:go_router/go_router.dart';
import '../widgets/catering_details_card.dart';
import '../bloc/place_bid_bloc.dart';


class PlaceBidScreen extends StatefulWidget {
  static const path = '/placebid';
  final String requestId;

  const PlaceBidScreen({super.key, required this.requestId});

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageFileNameController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  File? _attachedFile;

  Future<void> _pickAttachment() async {
    final picked = await ImagePickerHelper.pickImage(context);
    if (picked != null) {
      setState(() => _attachedFile = picked);
      final rawName = picked.path.split('/').last;
      final cleanName = rawName.replaceAll(RegExp(r'^image_picker_'), '');
      imageFileNameController.text = cleanName;
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    imageFileNameController.dispose();
    peopleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _submitBid() {
    final bid = PlaceBidRequest(
      requestId: widget.requestId,
      amount: priceController.text,
      currency: "usd",
      description: descriptionController.text,
      attachment: _attachedFile,
    );

    context.read<PlaceBidBloc>().add(SubmitPlaceBid(bid));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.responsiveSize(context, 16, 20, 24);

    return Scaffold(
      appBar: NavigationbarTitle(title: "Place Bid"),
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<PlaceBidBloc, PlaceBidState>(
        listener: (context, state) {
          if (state is PlaceBidSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Bid placed successfully!")),
            );
            context.pop();
          } else if (state is PlaceBidFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ ${state.error}")),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PlaceBidLoading;

          return AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CateringDetailsCard(),
                  SizedBox(height: spacing),

                  Text(
                    "Your Bid",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.responsiveSize(context, 16, 18, 20),
                    ),
                  ),
                  SizedBox(height: spacing / 2),

                  CustomTextField(
                    label: "Number of People",
                    controller: peopleController,
                    keyboardType: TextInputType.numberWithOptions(),
                                        formatNumber: true,
                  ),
                  SizedBox(height: spacing / 1.5),

                  CustomTextField(
                    label: "Price",
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: priceController,
                    formatNumber: true,
                    suffixIcon:
                        const Icon(Icons.attach_money, color: Colors.orange),
                  ),
                  SizedBox(height: spacing / 1.5),

                  SpecialInstructionsField(
                    controller: descriptionController,
                    labelTextHolder: 'Menu / Description',
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
                            style: const TextStyle(color: AppColors.textDark),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: spacing * 1.5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitBid,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.c500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: isLoading
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
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
