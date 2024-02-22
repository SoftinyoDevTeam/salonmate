// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MateBar extends StatelessWidget {
  final String title;
  final bool back;
  const MateBar({
    Key? key,
    required this.title,
    required this.back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).dialogBackgroundColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
