import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/screens/campaigns/CampaignDetail.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/cards/campaignlistcard.dart';

class CampaignLists extends StatefulWidget {
  const CampaignLists({super.key});

  @override
  State<CampaignLists> createState() => _CampaignListsState();
}

class _CampaignListsState extends State<CampaignLists> {
  List<CampaignModel?> kampanyalar = [];
  void awaitgetProducts() async {
    kampanyalar = await getCampaigns();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitgetProducts();
  }

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
                for (int i = 0; i < kampanyalar.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampaignDetails(
                                      campaignModel: kampanyalar[i],
                                    )));
                        ;
                      },
                      child: CampaignListCard(
                        heading: kampanyalar[i]!.name!,
                        description: kampanyalar[i]!.descriptions!,
                        imageUrl: kampanyalar[i]!.imageUrl!,
                        radius: 20.0,
                      ),
                    ),
                  ),
              ])),
        ));
  }
}
