import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/RandevuModel.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:salonmate/screens/profile/ProfileScreen.dart';
import 'package:salonmate/screens/profile/ReviewScreen.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/empty.dart';

class RandevularimScreen extends StatefulWidget {
  const RandevularimScreen({super.key, this.backProfile});
  final bool? backProfile;
  @override
  State<RandevularimScreen> createState() => _RandevularimScreenState();
}

class _RandevularimScreenState extends State<RandevularimScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool backProfile = false;

  List<RandevuModel?> randevularim = [];
  List<RandevuModel?> gelecekrandevularim = [];
  List<RandevuModel?> gecmisrandevularim = [];

  void getPage() async {
    randevularim.clear();
    setState(() {});
    randevularim = await fetchRandevu();

    for (var item in randevularim) {
      if (DateTime.now().isBefore(item!.scheduleStart!)) {
        gelecekrandevularim.add(item);
      } else {
        gecmisrandevularim.add(item);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.backProfile != null) {
      backProfile = true;
    }
    _tabController = TabController(vsync: this, length: 2);
    getPage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            if (backProfile) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            } else {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Randevularım",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              indicatorColor: Theme.of(context).colorScheme.secondary,
              indicatorPadding: const EdgeInsets.all(1),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.secondary,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
              controller: _tabController,
              tabs: const [
                Tab(text: "Gelecek Randevularım"),
                Tab(text: "Geçmiş Randevularım")
              ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: gelecekrandevularim.isNotEmpty
                      ? Column(
                          children: [
                            for (var item in gelecekrandevularim)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 230.h,
                                  width: 500.w,
                                  child: MateCard(
                                      widget: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item!.servicename!,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      item.staffimg!)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                item.staffname!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text("Tarih",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: "#BDBDC1".toColor(),
                                            )),
                                        Text(DateFormat('d MMMM yyyy - EEEE')
                                            .format(item.scheduleStart!)),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text("Saat",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: "#BDBDC1".toColor(),
                                            )),
                                        Text(DateFormat('HH:mm')
                                            .format(item.scheduleStart!)),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Divider(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            MateButon(
                                                title: "İptal Et",
                                                minimumSize: Size(20.w, 30.h),
                                                onPressed: () async {
                                                  await cancelService(item.ID!);
                                                  getPage();
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Randevu başarıyla iptal edildi.");
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ScreenBridge(
                                                                  selectedScreen:
                                                                      0)),
                                                      (route) => false);
                                                  setState(() {});
                                                },
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                textcolor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: EmptyState(
                              image: "assets/images/icons/appointment.png",
                              title: "Maalesef !",
                              description: "Gelecek randevunuz yok"),
                        ),
                ),
                SingleChildScrollView(
                  child: gecmisrandevularim.isNotEmpty
                      ? Column(
                          children: [
                            for (var item in gecmisrandevularim)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 230.h,
                                  width: 500.w,
                                  child: MateCard(
                                      widget: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item!.servicename!,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      item.staffimg!)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                item.staffname!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text("Tarih",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: "#BDBDC1".toColor(),
                                            )),
                                        Text(DateFormat('d MMMM yyyy - EEEE')
                                            .format(item.scheduleStart!)),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text("Saat",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: "#BDBDC1".toColor(),
                                            )),
                                        Text(DateFormat('HH:mm')
                                            .format(item.scheduleStart!)),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Divider(
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                        ),
                                        Row(
                                          mainAxisAlignment: item.star == 0 ||
                                                  item.star == null
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.center,
                                          children: [
                                            item.star == 0 || item.star == null
                                                ? MateButon(
                                                    title: "Değerlendir",
                                                    minimumSize:
                                                        Size(100.w, 30.h),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  ReviewScreen(
                                                                      scheduleID:
                                                                          item.ID!))));
                                                    },
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    textcolor: Theme.of(context)
                                                        .primaryColorLight)
                                                : Text(
                                                    "Değerlendirmeniz ${item.star.toString()} Yıldız"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: EmptyState(
                              image: "assets/images/icons/appointment.png",
                              title: "Maalesef !",
                              description: "Geçmiş randevunuz yok"),
                        ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
