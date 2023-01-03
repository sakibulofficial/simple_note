import 'package:flutter/material.dart';
import '../values/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget appBarTitle;
  final List<Widget>? actions;
  final bool isBackButtonEnabled;
  final Icon? leading;
  final bool isSearchBar;
  final Color backgroundColor;

  CustomAppBar({
    Key? key,
    required this.isSearchBar,
    this.leading,
    required this.appBarTitle,
    this.actions,
    this.isBackButtonEnabled = true,
    this.backgroundColor = AppColors.appBarColor,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: isSearchBar == true
            ? const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0)
            : const EdgeInsets.all(0),
        child: AppBar(
          centerTitle: true,
          elevation: isSearchBar == true ? 1 : 0,
          backgroundColor:
              isSearchBar == true ? AppColors.appBarColor : backgroundColor,
          // elevation: 0,
          automaticallyImplyLeading: isBackButtonEnabled,
          actions: actions,
          leading: leading,
          shape: isSearchBar == true
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
          title: appBarTitle,
        ),
      ),
    );
  }
}
