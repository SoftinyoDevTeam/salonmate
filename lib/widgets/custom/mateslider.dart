import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/screens/campaigns/CampaignDetail.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';
import 'package:salonmate/widgets/loader.dart';

class MateSlider extends StatefulWidget {
  const MateSlider({super.key});

  @override
  State<MateSlider> createState() => _MateSliderState();
}

class _MateSliderState extends State<MateSlider> {
  PageController pageController = PageController();
  int currentIndexPage = 0;
  List<CampaignModel?> kampanyalar = [];
  void getCampaignss() async {
    kampanyalar = await getCampaigns();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCampaignss();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kampanyalar.isEmpty
            ? Loader()
            : SizedBox(
                child: Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                ),
                height: 150.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.h),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: kampanyalar.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CampaignDetails(
                                        campaignModel: kampanyalar[i],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: ScreenUtil().screenWidth,
                            child: MateImage(
                              boxFit: BoxFit.cover,
                              imageUrl: kampanyalar[i]!.imageUrl!,
                            ),
                          ),
                        ),
                      );
                    },
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value);
                    },
                  ),
                ),
              )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < kampanyalar.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 7,
                width: i == currentIndexPage ? 20 : 10,
                decoration: BoxDecoration(
                  color: i == currentIndexPage
                      ? const Color.fromARGB(255, 253, 51, 87)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
