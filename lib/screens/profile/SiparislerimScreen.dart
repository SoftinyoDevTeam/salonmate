import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/salonmodels/siparisgecmisimodel.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/cards/sipariscard.dart';
import 'package:salonmate/widgets/loader.dart';

class SiparislerimScreen extends StatefulWidget {
  const SiparislerimScreen({super.key});

  @override
  State<SiparislerimScreen> createState() => _SiparislerimScreenState();
}

class _SiparislerimScreenState extends State<SiparislerimScreen> {
  List<ProductHistoryModel?> siparislerim = [];
  void fetchData() async {
    siparislerim = await getsiparislerim();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MateBar(
          "Siparişlerim", true, Theme.of(context).colorScheme.secondary),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: siparislerim.isNotEmpty
              ? Container(
                  height: ScreenUtil().screenHeight - 90.h,
                  child: ListView.builder(
                      itemCount: siparislerim.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SiparisWidget(
                            fullName: siparislerim[index]!.name!,
                            imagePath: siparislerim[index]!.imgUrl,
                            fiyat:
                                siparislerim[index]!.price!.toString() + " TL",
                            urunSayisi: 1,
                            status: siparislerim[index]!.statusID.toString(),
                          ),
                        );
                      }),
                )
              : Loader(),
        ),
      ),
    );
  }
}
