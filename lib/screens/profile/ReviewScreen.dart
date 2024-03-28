import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.scheduleID});
  final int scheduleID;
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int star = 0;
  TextEditingController degerlendirme = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MateBar(
          "Değerlendirme",
          true,
          Theme.of(context).colorScheme.secondary,
          height: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FivePointedStar(
                    gap: 10,
                    selectedColor: Color.fromARGB(255, 237, 215, 15),
                    count: 5,
                    onChange: (count) {
                      star = count;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 250.w,
                height: 220.h,
                child: TextFormField(
                  controller: degerlendirme,
                  decoration: const InputDecoration(
                      hintText: "Lütfen aldığınız hizmetle ilgili yorum yazın"),
                  maxLines: 10,
                ),
              ),
              MateButon(
                  title: "Değerlendirmeyi Tamamla",
                  minimumSize: Size(100.w, 30.h),
                  onPressed: () async {
                    bool status = await sendReview(
                        widget.scheduleID, star, degerlendirme.text);
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ));
  }
}
