// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MateButon extends StatelessWidget {
  final String title;
  final Size minimumSize;
  final Color color;
  final Color textcolor;
  final VoidCallback onPressed;

  const MateButon(
      {Key? key,
      required this.title,
      required this.minimumSize,
      required this.onPressed,
      required this.color,
      required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.white,
        backgroundColor: color,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: textcolor, width: 0.5),
        ),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: textcolor)),
    );
  }
}
