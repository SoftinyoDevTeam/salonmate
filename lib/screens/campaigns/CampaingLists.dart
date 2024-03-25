import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/cards/campaignlistcard.dart';

class CampaignLists extends StatefulWidget {
  const CampaignLists({super.key});

  @override
  State<CampaignLists> createState() => _CampaignListsState();
}

class _CampaignListsState extends State<CampaignLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MateBar(
          "Kampanyalar",
          true,
          Theme.of(context).colorScheme.secondary,
          height: 100,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                CampaignListCard(
                  heading: "title",
                  description:
                      "descDASFADSFADSFADSFADSFDASFADSFASDFASDASDFADSFDSAFASDFADSFADS",
                  imageUrl:
                      "https://thelyst.com/wp-content/uploads/2015/07/campaign-blog-graphic-01-1080x675.jpg",
                  radius: 20.0,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CampaignListCard(
                  heading: "title",
                  description:
                      "descDASFADSFADSFADSFADSFDASFADSFASDFASDASDFADSFDSAFASDFADSFADS",
                  imageUrl:
                      "https://thelyst.com/wp-content/uploads/2015/07/campaign-blog-graphic-01-1080x675.jpg",
                  radius: 20.0,
                )
              ])),
        ));
  }
}
