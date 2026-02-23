import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color backgroundColor = ColorManager.error, int durationInSeconds = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: ColorManager.white),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
