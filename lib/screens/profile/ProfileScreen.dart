import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/usermodels/usermodel.dart';
import 'package:salonmate/screens/auth/SplashScreen.dart';
import 'package:salonmate/screens/campaigns/CampaingLists.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/screens/profile/PersonalDataScreen.dart';
import 'package:salonmate/screens/profile/RandevularimScreen.dart';
import 'package:salonmate/screens/profile/SiparislerimScreen.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';
import 'package:salonmate/widgets/loader.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userData;
  void fetchProfile() async {
    userData = await getProfile();
    setState(() {});
  }

  void initState() {
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MateBar("Profilim", true, Colors.white,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          divider: false),
      body: userData == null
          ? SizedBox(height: 400.h, child: const Loader())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Text(
                          userData!.adSoyad,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              """$affCodePrefix${userData!.id} davet kodumla ${appname} uygulamasını indir ilk harcamanda %30 indirim kazan.
                            iOS: https://apps.apple.com/tr/app/sabit-akkaya/id6451428307?l=tr
                            Android: https://play.google.com/store/apps/details?id=com.sabitakkaya.salonmate
                            """,
                              subject:
                                  'Davet Kodumla Üye Ol %30 İndirim Kazan');
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Container(
                                height: 70.h,
                                width: ScreenUtil().screenWidth - 20.w,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    borderRadius: BorderRadius.circular(12.sp)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Davet Kodunu Paylaş : $affCodePrefix${userData!.id}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                "Kodu istediğiniz kadar arkadaşınızla paylaşıp sunduğumuz \navantajlardan faydalanabilirsiniz.",
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .hintColor),
                                              ),
                                            )
                                          ]),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.share_outlined),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalDataScreen(
                                                userData: userData!)));
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.person_2,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Kişisel Bilgilerim",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CuzdanimScreen()));
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.wallet,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Cüzdanım",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SiparislerimScreen()));
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Siparişlerim",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RandevularimScreen()));
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Randevularım",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CampaignLists()));
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.campaign,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Kampanyalar",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            // Container(
                            //   height: 60.h,
                            //   width: ScreenUtil().screenWidth,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(18.0),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         Icon(
                            //           Icons.location_on_outlined,
                            //           color: Theme.of(context).hintColor,
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 8.0),
                            //           child: Text(
                            //             "Adreslerim",
                            //             style: TextStyle(
                            //                 color: Theme.of(context)
                            //                     .primaryColorDark),
                            //           ),
                            //         ),
                            //         Spacer(),
                            //         Icon(
                            //           Icons.chevron_right_outlined,
                            //           color: Theme.of(context).hintColor,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 18.0),
                            //   child: Divider(
                            //     height: 1,
                            //     color: Theme.of(context).colorScheme.outline,
                            //   ),
                            // ),
                            // Container(
                            //   height: 60.h,
                            //   width: ScreenUtil().screenWidth,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(18.0),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         Icon(
                            //           Icons.language_outlined,
                            //           color: Theme.of(context).hintColor,
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 8.0),
                            //           child: Text(
                            //             "Dil Değiştir",
                            //             style: TextStyle(
                            //                 color: Theme.of(context)
                            //                     .primaryColorDark),
                            //           ),
                            //         ),
                            //         Spacer(),
                            //         Icon(
                            //           Icons.chevron_right_outlined,
                            //           color: Theme.of(context).hintColor,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 18.0),
                            //   child: Divider(
                            //     height: 1,
                            //     color: Theme.of(context).colorScheme.outline,
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () async {
                                await logout();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Çıkış Yap",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await logout();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                height: 60.h,
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hesabımı Kalıcı Olarak Sil",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Divider(
                                height: 1,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
