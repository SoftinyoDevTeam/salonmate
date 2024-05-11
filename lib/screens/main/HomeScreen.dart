import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
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
import 'package:salonmate/widgets/custom/mateslider.dart';
import 'package:salonmate/widgets/empty.dart';
import 'package:salonmate/widgets/loader.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

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
                            label: "Klavyeyi Kapat",
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                            textColor: Theme.of(context).primaryColor,
                            focusNode: searchFocusNode,
                            child: SearchFieldAutoComplete(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    const Text(
                                      "Cüzdanım",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                          tooltipVerticalPosition:
                              TooltipVerticalPosition.BOTTOM,
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
                            label: Text("Cüzdanım",
                                style: TextStyle(
                                    color: const Color(0xFF272E54),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
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
                                    const Text(
                                      "Salla Kazan",
                                      style: TextStyle(
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
                          tooltipVerticalPosition:
                              TooltipVerticalPosition.BOTTOM,
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
                            label: Text("Salla Kazan",
                                style: TextStyle(
                                    color: const Color(0xFF272E54),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kampanyalar',
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
                          child: const Text('Tümünü Gör',
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat")),
                        )
                      ]),
                ),
                MateSlider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Öne Çıkan Ürünler",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                isLoading == false
                    ? products.isNotEmpty
                        ? SizedBox(
                            height: 800.h,
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
                                        height: 0.w,
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
                                title: "Maalesef",
                                description: "Öne çıkarılan hiç ürün yok"),
                          )
                    : Loader()
              ],
            ),
          ),
        ));
  }
}
