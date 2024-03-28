// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MateBarContent extends StatelessWidget {
  final String title;
  final bool back;
  final Color textColor;
  final bool divider;
  final PreferredSizeWidget bottom;

  const MateBarContent({
    Key? key,
    required this.title,
    required this.back,
    required this.textColor,
    required this.divider,
    required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: bottom,
    );
  }
}

PreferredSizeWidget MateBar(String title, bool back, Color textColor,
    {double height = 60.0,
    Color backgroundColor = Colors.transparent,
    bool divider = true,
    PreferredSizeWidget bottom = const PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: SizedBox(),
    )}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: MateBarContent(
        title: title,
        back: back,
        textColor: textColor,
        divider: divider,
        bottom: bottom,
      ),
    ),
  );
}
