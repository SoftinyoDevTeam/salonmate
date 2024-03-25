import 'package:easy_localization/easy_localization.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/RandevuModel.dart';
import 'package:salonmate/screens/profile/ReviewScreen.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/loader.dart';

class RandevularimScreen extends StatefulWidget {
  const RandevularimScreen({super.key});

  @override
  State<RandevularimScreen> createState() => _RandevularimScreenState();
}

class _RandevularimScreenState extends State<RandevularimScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<RandevuModel?> randevularim = [];

  void getPage() async {
    randevularim = await fetchRandevu();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      appBar: MateBar(
          "Randevularım", true, Theme.of(context).colorScheme.secondary,
          height: 100,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorColor: Theme.of(context).colorScheme.secondary,
                indicatorPadding: EdgeInsets.all(1),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                dividerColor: Colors.transparent,
                labelColor: Theme.of(context).colorScheme.secondary,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                controller: _tabController,
                tabs: [
                  Tab(text: "Gelecek Randevularım"),
                  Tab(text: "Geçmiş Randevularım")
                ]),
          )),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (var item in randevularim)
                      if (item!.scheduleStart!.isAfter(DateTime.now()))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 230.h,
                            width: 500.w,
                            child: MateCard(
                                widget: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                            backgroundImage:
                                                NetworkImage(item!.staffimg!)),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          item!.staffname!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
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
                                    color:
                                        Theme.of(context).dialogBackgroundColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MateButon(
                                          title: "Düzenle",
                                          minimumSize: Size(20.w, 30.h),
                                          onPressed: () {},
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          textcolor: Theme.of(context)
                                              .primaryColorLight),
                                      MateButon(
                                          title: "İptal Et",
                                          minimumSize: Size(20.w, 30.h),
                                          onPressed: () {},
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
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (var item in randevularim)
                      if (item!.scheduleStart!.isBefore(DateTime.now()))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 230.h,
                            width: 500.w,
                            child: MateCard(
                                widget: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                            backgroundImage:
                                                NetworkImage(item!.staffimg!)),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          item!.staffname!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
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
                                    color:
                                        Theme.of(context).dialogBackgroundColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        item.star == 0 || item.star == null
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.center,
                                    children: [
                                      item.star == 0 || item.star == null
                                          ? MateButon(
                                              title: "Değerlendir",
                                              minimumSize: Size(100.w, 30.h),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            ReviewScreen(
                                                                scheduleID: item
                                                                    .ID!))));
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
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
