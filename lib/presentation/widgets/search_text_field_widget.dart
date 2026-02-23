import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  const SearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.onChanged,
    this.onClear,
    this.hintText = 'Search movies...',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      style: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: getRegularStyle(
          fontSize: FontSize.s16,
          color: ColorManager.textHint,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: ColorManager.iconColor,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: ColorManager.iconColor,
                ),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: ColorManager.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManager.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManager.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorManager.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
