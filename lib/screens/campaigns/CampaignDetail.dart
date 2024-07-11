import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
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
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 100.h,
                        child: Text(
                          kampanyalar.descriptions!,
                          textAlign: TextAlign.start,
                        )),
                  ),
                  Spacer(),
                  kampanyalar.type == "AFFILIATE"
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MateButon(
                              title: "Ürün Satın Al & Hizmet Kazan",
                              minimumSize: Size(4050, 50),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenBridge(selectedScreen: 1)));
                              },
                              color: Theme.of(context).primaryColor,
                              textcolor: Theme.of(context).primaryColorLight),
                        )
                      : Container(),
                  kampanyalar.type == "URUNKAMPANYA"
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MateButon(
                              title: "Ürün Satın Al & Hizmet Kazan",
                              minimumSize: Size(4050, 50),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenBridge(selectedScreen: 1)));
                              },
                              color: Theme.of(context).primaryColor,
                              textcolor: Theme.of(context).primaryColorLight),
                        )
                      : Container(),
                  kampanyalar.type == "HIZMETKAMPANYA"
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MateButon(
                              title: "Kampanyalı Hizmeti Satın Al",
                              minimumSize: Size(4050, 50),
                              onPressed: () async {
                                var ustoken = await getPrefString("token");
                                bool status = await addToCart(kampanyalar.ID!,
                                    "KAMPANYALIHIZMET", ustoken!);
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                    title: Text(
                                      'Tebrikler !',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    message: const Text(
                                        'Kampanyalı hizmet başarıyla sepetenize eklendi.'),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        /// This parameter indicates the action would be a default
                                        /// default behavior, turns the action's text to bold text.
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenBridge(
                                                          selectedScreen: 0)));
                                        },
                                        child: const Text(
                                          'Anasayfaya Git',
                                          style: TextStyle(
                                              color:
                                                  CupertinoColors.activeBlue),
                                        ),
                                      ),
                                      CupertinoActionSheetAction(
                                        /// This parameter indicates the action would perform
                                        /// a destructive action such as delete or exit and turns
                                        /// the action's text color to red.
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenBridge(
                                                          selectedScreen: 3)));
                                        },
                                        child: const Text('Sepete Git'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              color: Theme.of(context).primaryColor,
                              textcolor: Theme.of(context).primaryColorLight),
                        )
                      : Container(),
                  kampanyalar.type == "AFFILIATE"
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MateButon(
                              title: "İndirimli Randevu Oluştur",
                              minimumSize: Size(4050, 50),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RandevuMainScreen()));
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              textcolor: Theme.of(context).primaryColorLight),
                        )
                      : Container()
                ]),
              )),
        ));
  }
}
