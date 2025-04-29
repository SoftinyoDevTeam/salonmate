import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/campaignmodels.dart';
import 'package:salonmate/core/models/salonmodels/salonproductsmodel.dart';
import 'package:salonmate/screens/campaigns/CampaingLists.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/screens/main/SallaKazan.dart';
import 'package:salonmate/screens/products/ProductDetailScreen.dart';
import 'package:salonmate/screens/profile/NotificationsScreen.dart';
import 'package:salonmate/screens/profile/ProfileScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/matecard.dart';
import 'package:salonmate/widgets/cards/productlistcard.dart';
import 'package:salonmate/widgets/custom/adsbanner.dart';
import 'package:salonmate/widgets/custom/mateslider.dart';
import 'package:salonmate/widgets/empty.dart';
import 'package:salonmate/widgets/loader.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalonmateHomeScreen extends StatefulWidget {
  const SalonmateHomeScreen({super.key});

  @override
  State<SalonmateHomeScreen> createState() => _SalonmateHomeScreenState();
}

class _SalonmateHomeScreenState extends State<SalonmateHomeScreen> {
  bool isLoading = true;
  List<SalonProductsModel?> products = [];
  List<CampaignModel?> kampanyalar = [];
  List<SearchFieldAutoCompleteItem<String>> urunlerforarama = [];
  // Check if we should show the ad popup today
  Future<bool> _shouldShowAdPopup() async {
    final prefs = await SharedPreferences.getInstance();
    final String? lastShownDate = prefs.getString('last_ad_popup_date');

    if (lastShownDate == null) {
      return true; // Show if never shown before
    }

    final DateTime lastShown = DateTime.parse(lastShownDate);
    final DateTime now = DateTime.now(); //DateTime(DateTime.april); //

    // Check if it's the same day
    return !(lastShown.year == now.year &&
        lastShown.month == now.month &&
        lastShown.day == now.day);
  }

  // Save the date when ad was shown
  Future<void> _updateLastShownDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'last_ad_popup_date', DateTime.now().toIso8601String());
  }

  // Show the advertisement popup
  void _showAdPopup() async {
    Future.delayed(Duration(milliseconds: 1500), () async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _updateLastShownDate();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            Provider.of<MateServices>(context, listen: false)
                                .salonConfig!
                                .data!
                                .salonConfig!
                                .popupurl!,
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.center),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    Provider.of<MateServices>(context, listen: false)
                        .salonConfig!
                        .data!
                        .salonConfig!
                        .popup_title!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    Provider.of<MateServices>(context, listen: false)
                        .salonConfig!
                        .data!
                        .salonConfig!
                        .popup_description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void awaitgetProducts() async {
    products = await getProducts();

    kampanyalar = await getCampaigns();
    isLoading = false;
    setState(() {});
    products.forEach((element) {
      urunlerforarama.add(
        SearchFieldAutoCompleteItem<String>(
            searchKey: element!.name!, value: element.ID.toString()),
      );
    });
    setState(() {});
  }

  FocusNode searchFocusNode = FocusNode();
  PageController pageController = PageController();
  PageController pageController2 = PageController();
  int currentIndexPage = 0;
  int currentIndexPage2 = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitgetProducts();

    // Check and show ad popup after a small delay to allow screen to build
    Future.delayed(Duration(milliseconds: 500), () async {
      if (await _shouldShowAdPopup()) {
        _showAdPopup();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 250.w,
                          height: 35.h,
                          child: IOSKeyboardAction(
                            focusActionType: FocusActionType.done,
                            label: ("general.close_keyboard").tr(),
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                            textColor: Theme.of(context).primaryColor,
                            focusNode: searchFocusNode,
                            child: SearchFieldAutoComplete(
                              placeholder: ("general.search_product").tr(),
                              focusNode: searchFocusNode,
                              suggestionsDecoration: SuggestionDecoration(
                                marginSuggestions: const EdgeInsets.all(1.0),
                                paddingSuggestions: const EdgeInsets.all(1.0),
                                color: Theme.of(context)
                                    .dialogBackgroundColor
                                    .withOpacity(0.95),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22)),
                              ),
                              autoCorrect: true,
                              autofocus: false,
                              appearance: Appearance.cupertino,
                              suggestions: urunlerforarama,
                              onSuggestionSelected: (value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                                product: products[products
                                                    .indexWhere((element) =>
                                                        element!.ID
                                                            .toString() ==
                                                        value.value)]!)));
                              },
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreen()));
                        },
                        child: Icon(Icons.person,
                            color: Theme.of(context).dialogBackgroundColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const NotificationScreen())));
                        },
                        child: Icon(Icons.notifications,
                            color: Theme.of(context).dialogBackgroundColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OverlayTooltipItem(
                        displayIndex: 2,
                        tooltip: (controller) => Container(
                            width: 200.w,
                            height: 150.h,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MateCard(
                                  widget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                    ("HomeScreen.wallet").tr(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      style: TextStyle(fontSize: 11.sp),
                                      maxLines: 4,
                                      "Kampanyalarımızdan elde ettiğiniz kazanımları buradan takip edebilirsiniz.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MateButon(
                                        title: "Devam",
                                        minimumSize: Size(30, 30),
                                        onPressed: () {},
                                        color: Theme.of(context).primaryColor,
                                        textcolor: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ]),
                              )),
                            )),
                        tooltipVerticalPosition: TooltipVerticalPosition.BOTTOM,
                        tooltipHorizontalPosition:
                            TooltipHorizontalPosition.CENTER,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.outline,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            fixedSize:
                                Size(160.w, 40.h), // Reduced from 48.h to 40.h
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CuzdanimScreen()));
                          },
                          icon: Image.asset(
                            "assets/images/icons/wallet.png",
                            width: 24,
                            height: 24,
                          ),
                          label: Text(("HomeScreen.wallet").tr(),
                              style: TextStyle(
                                  color: const Color(0xFF272E54),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      OverlayTooltipItem(
                        displayIndex: 1,
                        tooltip: (controller) => Container(
                            width: 200.w,
                            height: 150.h,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MateCard(
                                  widget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                    ("general.shakewin").tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      style: TextStyle(fontSize: 11.sp),
                                      maxLines: 4,
                                      "Telefonunu salla ve süpriz hediyeler kazanma şansını yakala.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MateButon(
                                        title: "Devam",
                                        minimumSize: Size(30, 30),
                                        onPressed: () {},
                                        color: Theme.of(context).primaryColor,
                                        textcolor: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ]),
                              )),
                            )),
                        tooltipVerticalPosition: TooltipVerticalPosition.BOTTOM,
                        tooltipHorizontalPosition:
                            TooltipHorizontalPosition.CENTER,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            backgroundColor:
                                Theme.of(context).colorScheme.outline,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            fixedSize:
                                Size(160.w, 40.h), // Reduced from 48.h to 40.h
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SallaKazanScreen()),
                            );
                          },
                          icon: Image.asset(
                            "assets/images/icons/shakewin.png",
                            width: 24,
                            height: 24,
                          ),
                          label: Text(("general.shakewin").tr(),
                              style: TextStyle(
                                  color: const Color(0xFF272E54),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(('HomeScreen.campaigns').tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => CampaignLists())));
                          },
                          child: Text(('HomeScreen.see_all').tr(),
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat")),
                        )
                      ]),
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                    child: MateSlider()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        ("HomeScreen.featured_products").tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                isLoading == false
                    ? products.isNotEmpty
                        ? SizedBox(
                            width: ScreenUtil().screenWidth,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.7, crossAxisCount: 2),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                      product:
                                                          products[index]!)));
                                    },
                                    child: ProductCard(
                                        width: 0.w,
                                        height: 150.w,
                                        title: products[index]!.name!,
                                        imageUrl: products[index]!.imgUrl!,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                          product: products[
                                                              index]!)));
                                        },
                                        price:
                                            products[index]!.price!.toDouble()),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: EmptyState(
                                image: "assets/images/icons/basket.png",
                                title: ("HomeScreen.unfortunately").tr(),
                                description:
                                    ("HomeScreen.no_featured_products").tr()),
                          )
                    : Loader()
              ],
            ),
          ),
        ));
  }
}
