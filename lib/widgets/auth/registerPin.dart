import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';

class RegisterPinPage extends StatefulWidget {
  const RegisterPinPage({super.key, required this.formData});
  final FormData formData;

  @override
  State<RegisterPinPage> createState() => _RegisterPinPageState();
}

class _RegisterPinPageState extends State<RegisterPinPage> {
  String hash = "";

  void sendsms(String phoneNumber) async {
    hash = await sendSmsforRegister(phoneNumber);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendsms(widget.formData.fields[0].value);
  }

  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).colorScheme.secondary)),
          title: Text(
            "Telefon Doğrulaması",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text("Lütfen cep telefonunuza gelen 6 haneli şifreyi tuşlayın."),
              Pinput(
                controller: pinController,
                length: 6,
                autofocus: true,
                onCompleted: (value) async {
                  pinController.clear();
                  widget.formData!.fields.add(MapEntry("hash", hash));
                  widget.formData!.fields.add(MapEntry("key", value));
                  register(widget.formData!.clone(), context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
