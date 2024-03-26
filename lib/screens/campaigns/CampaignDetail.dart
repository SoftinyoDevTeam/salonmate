import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';
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
          height: 100,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  width: 400.w,
                  height: 100.h,
                  child: MateImage(imageUrl: kampanyalar.imageUrl),
                ),
                Container(
                    width: 400.w,
                    height: 100.h,
                    child: Text(kampanyalar.descriptions!)),
                MateButon(
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
              ])),
        ));
  }
}
