import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MateToggle extends StatefulWidget {
  const MateToggle({super.key, required this.onSelected});
  final int onSelected;

  @override
  State<MateToggle> createState() => _MateToggleState();
}

class _MateToggleState extends State<MateToggle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 3.h,
              width: ScreenUtil().screenWidth / 5.5,
              decoration: BoxDecoration(
                  color: widget.onSelected == 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(1)),
            ),
            Container(
              height: 3.h,
              width: ScreenUtil().screenWidth / 5.5,
              decoration: BoxDecoration(
                  color: widget.onSelected == 1
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(1)),
            ),
            Container(
              height: 3.h,
              width: ScreenUtil().screenWidth / 5.5,
              decoration: BoxDecoration(
                  color: widget.onSelected == 2
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(1)),
            ),
            Container(
              height: 3.h,
              width: ScreenUtil().screenWidth / 5.5,
              decoration: BoxDecoration(
                  color: widget.onSelected == 3
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(1)),
            ),
            Container(
              height: 3.h,
              width: ScreenUtil().screenWidth / 5.5,
              decoration: BoxDecoration(
                  color: widget.onSelected == 4
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(1)),
            ),
          ],
        ));
  }
}
