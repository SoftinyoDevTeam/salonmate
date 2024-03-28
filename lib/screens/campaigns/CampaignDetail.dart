import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/screens/randevu/RandevuMainScreen.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';

class CampaignDetails extends StatefulWidget {
  const CampaignDetails({super.key, this.campaignModel});
  final CampaignModel? campaignModel;
  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  @override
  Widget build(BuildContext context) {
    CampaignModel? kampanyalar = widget.campaignModel;
    return Scaffold(
        appBar: MateBar(
          kampanyalar!.name == null ? "Yükleniyor" : kampanyalar!.name!,
          true,
          Theme.of(context).colorScheme.secondary,
          height: 60,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: ScreenUtil().screenHeight - 180.h,
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MateImage(
                        imageUrl: kampanyalar.imageUrl,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                        width: 400.w,
                        height: 100.h,
                        child: Text(kampanyalar.descriptions!)),
                  ),
                  Spacer(),
                  kampanyalar.type != "AFFILIATE"
                      ? MateButon(
                          title: "Kampanyalı Hizmeti Satın Al",
                          minimumSize: Size(20, 50),
                          onPressed: () async {
                            var ustoken = await getPrefString("token");
                            bool status = await addToCart(
                                kampanyalar.ID!, "KAMPANYALIHIZMET", ustoken!);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg:
                                    "Kampanyalı hizmet sepetinize eklendi lütfen kontrol edin.");
                          },
                          color: Theme.of(context).primaryColor,
                          textcolor: Theme.of(context).primaryColorLight)
                      : MateButon(
                          title: "İndirimli Randevu Oluştur",
                          minimumSize: Size(20, 50),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RandevuMainScreen()));
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          textcolor: Theme.of(context).primaryColorLight)
                ]),
              )),
        ));
  }
}
