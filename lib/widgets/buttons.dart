// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BeyazButon extends StatelessWidget {
  final String title;
  final Size minimumSize;
  final VoidCallback onPressed;
  const BeyazButon(
      {super.key,
      required this.title,
      required this.minimumSize,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
      ),
      onPressed: onPressed,
      child:
          Text(title, style: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }
}

class PembeButon extends StatelessWidget {
  final String title;
  final Size minimumSize;
  final VoidCallback onPressed;
  const PembeButon({
    Key? key,
    required this.title,
    required this.minimumSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
      ),
      onPressed: onPressed,
      child: Text(title,
          style: TextStyle(color: Theme.of(context).primaryColorLight)),
    );
  }
}
