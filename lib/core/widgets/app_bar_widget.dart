import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final String pageName;
  final bool hideBackButton;
  final bool centerTitle;
  const AppBarWidget({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
    required this.pageName,
    this.hideBackButton = true,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        pageName,
        style: const TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: hideBackButton,
      centerTitle: centerTitle,
    );
  }
}
