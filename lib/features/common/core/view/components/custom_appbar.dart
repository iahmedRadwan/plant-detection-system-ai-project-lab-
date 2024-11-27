import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/style/colors_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onPressed;
  final bool isLeading;
  final Color? statusBarColor;
  final Color? backgroundColor;
  final bool? centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.onPressed,
    this.centerTitle,
    this.isLeading = true,
    this.statusBarColor,
    this.backgroundColor,
    this.bottom,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      centerTitle: centerTitle ?? true,
      leadingWidth: isLeading?50:0.0,
      backgroundColor: backgroundColor ?? ColorManagerHelper.kWhiteColor,
      automaticallyImplyLeading: isLeading,
      elevation: 0.0,
      titleSpacing: isLeading?null:0.0,
      bottom: bottom,
      leading: isLeading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: ColorManagerHelper.kBlackColor,
                size: 22,
              ),
            )
          : null,
      title: isLeading
          ? Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                color: ColorManagerHelper.kBlackColor,
                fontWeight: FontWeight.w800,
              ),
            )
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                      height: 30,
                      width: 6,
                      decoration: BoxDecoration(
                          color: ColorManagerHelper.kMainColor,
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: ColorManagerHelper.kBlackColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: statusBarColor ?? ColorManagerHelper.kWhiteColor,
        systemNavigationBarDividerColor: ColorManagerHelper.kBlackColor,
        systemNavigationBarColor: ColorManagerHelper.kBlackColor,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness:
            Brightness.light, // For iOS (dark icons)// For iOS (dark icons)
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
