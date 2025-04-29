import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/sepetmodel.dart';
import 'package:salonmate/screens/products/PaymentScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';
import 'package:salonmate/widgets/empty.dart';

class SepetScreen extends StatefulWidget {
  const SepetScreen({super.key});

  @override
  State<SepetScreen> createState() => _SepetScreenState();
}

class _SepetScreenState extends State<SepetScreen> {
  List<SepetModel?> sepetim = [];
  double sepetTotal = 0;
  void getSepetContent() async {
    sepetTotal = 0;
    sepetim = await getCart();
    sepetim.forEach(
      (element) {
        sepetTotal = sepetTotal + element!.price!;
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSepetContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outline,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Text(
              "Sepetim",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).colorScheme.outline,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: sepetim.isEmpty
          ? EmptyState(
              image: "assets/images/icons/basket.png",
              title: "Sepetinizde Ürün Bulunmamaktadır",
              description: "",
            )
          : ListView.builder(
              itemCount: sepetim.length,
              itemBuilder: (context, index) {
                var urun = sepetim[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: Key(urun!.ID!.toString()),
                    // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                    onDismissed: (direction) async {
                      await deleteCart(sepetim[index]!.ID!);
                      setState(() {
                        sepetim.removeAt(index);
                        getSepetContent();
                      });
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4, right: 22.0),
                            child: Text(
                              "Kaldır",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                          )
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight),
                      width: ScreenUtil().screenWidth,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(
                                    width: 1.sp,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 90.h,
                                  width: 90.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp)),
                                  child: MateImage(
                                    imageUrl: urun.imgUrl == null
                                        ? "https://salonmate.co/favicon.ico"
                                        : urun.imgUrl,
                                    boxFit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: ScreenUtil().screenWidth - 150.w,
                                  child: Text(
                                    urun.title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                                Text(
                                  "${urun.price.toString()} TL",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(spreadRadius: 1, color: Colors.grey.withOpacity(0.2))
            ]),
        height: 65.h,
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Toplam",
                    style: TextStyle(fontSize: 8.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${sepetTotal.toString()} TL",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                      Icon(
                        Icons.arrow_drop_up_rounded,
                        size: 28.sp,
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                    ],
                  ),
                ],
              ),
              MateButon(
                  title: "Sepeti Onayla",
                  minimumSize: Size(20.w, 40.h),
                  onPressed: () {
                    if (sepetTotal > 0.0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                    subtotal: sepetTotal.toInt(),
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Önce sepete bişeyler ekleyin.");
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ),
      ),
    );
  }
}
