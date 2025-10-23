// import 'package:flutter/material.dart';
// import 'package:caterbid/core/config/app_colors.dart';
// import 'package:caterbid/core/config/app_constants.dart';
// import 'package:caterbid/core/utils/responsive.dart';

// class PasswordField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final Function(String)? onChanged;

//   const PasswordField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.onChanged,
//   });

//   @override
//   State<PasswordField> createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     double borderRadius = Responsive.responsiveSize(context, 12, 15, 18);
//     double fontSize = Responsive.responsiveSize(context, 14, 16, 18);
//     double verticalPadding = Responsive.responsiveSize(context, 12, 16, 18);
//     double horizontalPadding = Responsive.responsiveSize(context, 12, 16, 20);

//     return TextFormField(
//       controller: widget.controller,
//       obscureText: obscureText,
//       onChanged: widget.onChanged,
//       style: TextStyle(
//         color: AppColors.textDark,
//         fontFamily: AppFonts.nunito,
//         fontWeight: FontWeight.w600,
//         fontSize: fontSize,
//       ),
//       cursorColor: AppColors.textDark,
//       decoration: InputDecoration(
//         labelText: widget.label,
//         labelStyle: TextStyle(
//           color: AppColors.textDark,
//           fontFamily: AppFonts.nunito,
//           fontWeight: FontWeight.w600,
//           fontSize: fontSize,
//         ),

//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText
//                 ? Icons.visibility_off_outlined
//                 : Icons.visibility_outlined,
//             color: Colors.grey.shade600,
//           ),
//           onPressed: () => setState(() => obscureText = !obscureText),
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: const BorderSide(width: 1.5, color: AppColors.c500),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: horizontalPadding,
//           vertical: verticalPadding,
//         ),
//       ),
//     );
//   }
// }
