import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

/// Input field standar dengan label, validasi, dan toggle password.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.icon,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: AppColors.surface,
            prefixIcon: widget.icon == null
                ? null
                : Icon(widget.icon, color: AppColors.textMuted, size: 20),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
            border: _border(Colors.transparent),
            enabledBorder: _border(Colors.transparent),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
        ),
      ],
    );
  }
}
