import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';

AppBar buildAppBarWidget({
  required String title,
  bool centerTitle = true,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    title: Text(
      title,
      style: getSemiBoldStyle(
        fontSize: FontSize.s20,
        color: ColorManager.white,
      ),
    ),
    centerTitle: centerTitle,
    backgroundColor: ColorManager.primary,
    foregroundColor: ColorManager.white,
    elevation: 2,
    actions: actions,
    leading: leading,
  );
}
