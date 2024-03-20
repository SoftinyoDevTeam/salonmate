import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/models/usermodels/usermodel.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';

class PersonalDataScreen extends StatefulWidget {
  final UserModel userData;
  const PersonalDataScreen({super.key, required this.userData});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  TextEditingController fullName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullName.text = widget.userData.adSoyad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MateBar(
          "Kişisel Bilgilerim", true, Theme.of(context).colorScheme.secondary),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextFormField(
                controller: fullName,
                cursorHeight: 14.h,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: "Ad Soyad*",
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w600),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: MateButon(
                title: "Güncelle",
                onPressed: () {},
                textcolor: Theme.of(context).primaryColorLight,
                color: Theme.of(context).colorScheme.secondary,
                minimumSize: Size(ScreenUtil().screenWidth, 40.h),
              ),
            )
          ],
        ),
      ),
    );
  }
}
