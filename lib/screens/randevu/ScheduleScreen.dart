import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/core/models/othermodels/stafffilledschedules.dart';
import 'package:salonmate/core/models/salonmodels/checkHizmetmodel.dart';
import 'package:salonmate/widgets/bottomsheets/radioselectbottomsheets.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/custom/matetogglebutton.dart';
import 'package:salonmate/widgets/loader.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen(
      {super.key,
      required this.subeID,
      required this.hizmetler,
      required this.kategori,
      this.selectedService,
      required this.cuzdanrandevusu});
  final int subeID;
  final List<HizmetModel> hizmetler;
  final String kategori;
  final HizmetModel? selectedService;
  final bool cuzdanrandevusu;
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedTab = 0;
  HizmetModel? selectedService;
  RadioSelectModels? selectedStaff;
  List<RadioSelectModels?> data = [];

  bool isfetch = false;
  //Saat Listeleme
  late TimeOfDay startTime;
  late TimeOfDay departureTime;

  late List<StaffFilledSchedules?> filledSchedules;
  List<DateTime> staffFilledScheduleList = [];

  late List<DateTime> selectedDate = [DateTime.now()];

  List<DateTimeRange> emptyScheduleList = [];

  void fetchData() async {
    data = await checkRadioList(
        "getStaffs", FormData.fromMap({"subeID": widget.subeID}));
    isfetch = true;
    setState(
      () {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    if (widget.selectedService != null) {
      selectedService = widget.selectedService;
      selectedTab = 1;
      setState(() {});
    }

    startTime = TimeOfDay(hour: 8, minute: 0);
    departureTime = TimeOfDay(hour: 24, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60.h, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Text(
                  "Randevu Oluştur",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.background,
                ),
              ],
            ),
            MateToggle(
              onSelected: selectedTab,
            ),
            if (selectedTab == 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.kategori,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Wrap(children: [
                        data.length == 0
                            ? Loader()
                            : Column(
                                children: [
                                  for (var item in widget.hizmetler)
                                    GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            selectedService = item;
                                          },
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: selectedTab == item.ID
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )
                                              : BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 224, 224, 228)),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    item.name != null
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              item.name!,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                IconButton(
                                                  hoverColor: Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                                  focusColor: Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                                  splashColor: Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onError,
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        selectedService = item;
                                                      },
                                                    );
                                                  },
                                                  icon: selectedService == item
                                                      ? Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                        )
                                                      : Icon(
                                                          Icons.circle_outlined,
                                                        ),
                                                ),
                                              ])),
                                    ),
                                ],
                              )
                      ]),
                    ),
                  ],
                ),
              ),
            if (selectedTab == 1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hizmet almak istediğiniz personeli seçin",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        RadioSelectBottomSheet(context, true, true, "getStaffs",
                            FormData.fromMap({"subeID": widget.subeID}),
                            (value) async {
                          selectedStaff = value;
                          staffFilledScheduleList =
                              await checkStaffFilledSchedules(
                                  selectedStaff!.ID.toString());
                          emptyScheduleList = getEmptySchedule(
                              DateTime.now(), startTime, departureTime);
                          setState(() {});
                        });
                      },
                      child: Container(
                        width: ScreenUtil().screenWidth,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedStaff == null
                                  ? Text("Personel Seçin*")
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  selectedStaff!.imageUrl!)),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(selectedStaff!.fullName!)
                                        ]),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).dialogBackgroundColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(children: [
                      SizedBox(
                        height: 120,
                        child: SfDateRangePicker(
                          view: DateRangePickerView.month,
                          minDate: DateTime.now(),
                          maxDate: DateTime(DateTime.now().year,
                              DateTime.now().month + 1, DateTime.now().day),
                          initialSelectedDate: DateTime.now(),
                          selectionShape:
                              DateRangePickerSelectionShape.rectangle,
                          selectionColor:
                              Theme.of(context).colorScheme.secondary,
                          showTodayButton: false,
                          showNavigationArrow: true,
                          todayHighlightColor:
                              Theme.of(context).colorScheme.secondary,
                          selectionTextStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          onSelectionChanged: (args) {
                            emptyScheduleList = getEmptySchedule(
                                args.value, startTime, departureTime);
                            setState(() {});
                          },
                          monthViewSettings: DateRangePickerMonthViewSettings(
                            numberOfWeeksInView: 1,
                            firstDayOfWeek: 1,
                            dayFormat: 'EEE',
                          ),
                          selectableDayPredicate: (date) {
                            if (date.weekday == DateTime.sunday) {
                              return true;
                            } else {
                              return true;
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Saati Belirleyin",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 299.h,
                        child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: emptyScheduleList.length,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.01,
                                    mainAxisSpacing:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                    mainAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            0.05),
                            itemBuilder: (context, index) {
                              if (!staffFilledScheduleList.contains(
                                      emptyScheduleList[index].start) &&
                                  emptyScheduleList[index]
                                      .start
                                      .isAfter(DateTime.now())) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedDate.clear();

                                    double parts =
                                        selectedService!.serviceDuration! / 15;
                                    int count = 0;
                                    for (var i = 0; i < parts; i++) {
                                      if (staffFilledScheduleList.contains(
                                          emptyScheduleList[index]
                                              .start
                                              .add(Duration(minutes: count)))) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Randevunuzun aktif olduğu saatte başka bir randevu başladığı için seçim yasaklanmıştır.");
                                        selectedDate.clear();
                                      }
                                      selectedDate.add(emptyScheduleList[index]
                                          .start
                                          .add(Duration(minutes: count)));
                                      count = count + 15;
                                    }

                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: selectedDate.contains(
                                                      emptyScheduleList[index]
                                                          .start)
                                                  ? Colors.transparent
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.2),
                                              spreadRadius: 0.5)
                                        ],
                                        color: !selectedDate.contains(
                                                emptyScheduleList[index].start)
                                            ? Theme.of(context)
                                                .primaryColorLight
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                      ),
                                      child: Text(
                                        '${DateFormat('HH:mm').format(emptyScheduleList[index].start)}',
                                        style: TextStyle(
                                            color: !selectedDate.contains(
                                                    emptyScheduleList[index]
                                                        .start)
                                                ? Theme.of(context)
                                                    .primaryColorDark
                                                : Theme.of(context)
                                                    .primaryColorLight),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(2.5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                    ),
                                    child: Text(
                                      '${DateFormat('HH:mm').format(emptyScheduleList[index].start)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .dialogBackgroundColor),
                                    ),
                                  ),
                                );
                              }
                            }),
                      )
                    ])
                  ],
                ),
              ),
            if (selectedTab == 2)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 210.h,
                      width: 500.w,
                      child: MateCard(
                          widget: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              selectedService!.name!,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("Personel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: "#BDBDC1".toColor(),
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            selectedStaff != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                selectedStaff!.imageUrl!)),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          selectedStaff!.fullName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ])
                                : Container(),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text("Tarih",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: "#BDBDC1".toColor(),
                                )),
                            Text(DateFormat('d MMMM yyyy - EEEE')
                                .format(selectedDate[0])),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text("Saat",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: "#BDBDC1".toColor(),
                                )),
                            Text(DateFormat('HH:mm').format(selectedDate[0])),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      )),
                    ),
                  )
                ],
              )
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        height: 65.h,
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedTab > 0
                  ? widget.cuzdanrandevusu == false
                      ? MateButon(
                          title: "Geri",
                          minimumSize: Size(100.w, 120.h),
                          onPressed: () {
                            selectedTab = selectedTab - 1;
                            setState(() {});
                          },
                          color: Theme.of(context).primaryColorLight,
                          textcolor: Theme.of(context).colorScheme.secondary,
                        )
                      : Container()
                  : Container(),
              selectedTab < 2
                  ? selectedService != null
                      ? selectedService!.prePaymentMinRate != null &&
                              selectedService!.prePaymentMinRate! > 0.00 &&
                              widget.cuzdanrandevusu == false
                          ? MateButon(
                              title: "Sepete Ekle",
                              minimumSize: Size(100.w, 120.h),
                              onPressed: () async {
                                var usertoken = await getPrefString("token");
                                bool sepet = await addToCart(
                                    selectedService!.ID!, "HIZMET", usertoken!);
                                Fluttertoast.showToast(
                                    msg:
                                        "Hizmet başarıyla sepetinize eklendi.");
                                setState(() {});
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              textcolor: Theme.of(context).primaryColorLight,
                            )
                          : MateButon(
                              title: "Sonraki",
                              minimumSize: Size(100.w, 120.h),
                              onPressed: () {
                                selectedTab = selectedTab + 1;
                                setState(() {});
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              textcolor: Theme.of(context).primaryColorLight,
                            )
                      : MateButon(
                          title: "Sonraki",
                          minimumSize: Size(100.w, 120.h),
                          onPressed: () {
                            selectedTab = selectedTab + 1;
                            setState(() {});
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          textcolor: Theme.of(context).primaryColorLight,
                        )
                  : MateButon(
                      title: "Randevumu Oluştur",
                      minimumSize: Size(100.w, 120.h),
                      onPressed: () async {
                        setState(() {});
                        bool randevu = await addRandevu(
                            selectedService!.ID!,
                            selectedStaff!.ID!,
                            selectedDate[0],
                            selectedService!.serviceDuration!,
                            widget.subeID);

                        Navigator.pop(context);
                      },
                      color: Theme.of(context).colorScheme.primary,
                      textcolor: Theme.of(context).primaryColorLight,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
